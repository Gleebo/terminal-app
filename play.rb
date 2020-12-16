require_relative "./view"
require_relative "./game"
require_relative "./ai"
require_relative "./models/room"
require_relative "./models/enemy"
require_relative "./models/gem"

RUBY = CrystalGem.new(
  name: "Ruby",
  description:"Deal damage and apply burning status to a single target",
  action: proc { |target|
    "#{target.damage(20)}. #{target.add_status(:burning, {turns: 2, damage: 5})}"
  }
)

SAPPHIRE = CrystalGem.new(
  name: "Sapphire",
  description: "Deal damage and apply frozen status to a single target",
  action: proc { |target| 
    "#{target.damage(10)}. #{target.add_status(:frozen, {turns: 1})}"
  }
)

EMERALD = CrystalGem.new(
  name: "Emerald",
  description: "Heal and apply regenerating status to a single target",
  action: proc { |target| 
    "#{target.heal(25)}. #{target.add_status(:regenerating, {turns: 2, heal: 10})}" 
  }
)

AMETHYST = CrystalGem.new(
  name: "Amethyst",
  description: "Protect a target from 1 instance of damage",
  action: proc {|target| target.add_status(:protected, {turns: 1})}
)

LAPIS_LAZULI = CrystalGem.new(
  name: "Lapis Lazuli",
  target: :aoe,
  description: "Deals damage and applies frozen status to all enemies",
  action: proc { |targets|
    targets.reduce("") { |o, t|
      o += " >#{t.damage(10)}. #{t.add_status(:frozen, {turns: 2})}\n"
    }
  }
)

OP = CrystalGem.new(
  name: "Oneshot",
  target: :aoe,
  description: "Test gem that kills everyone",
  action: proc {|targets|
    targets.reduce("") {|o, t|
      o += " > #{t.damage(100)}.\n"
    }
  }
)

STARTER_GEMS  = [RUBY, SAPPHIRE, EMERALD, AMETHYST]*10

ENEMY   = Enemy.new(name: "Emeraldia", defense_gem: EMERALD)
ENEMY2  = Enemy.new(name: "Rubius", attack_gem: RUBY)

ROOM    = Room.new(
  description: "Room 1",
  enemies: [ENEMY, ENEMY2]
)

ROOM2   = Room.new(
  description: "Room 2",
  enemies: [
  Enemy.new(name: "Rubius", attack_gem: RUBY, attack_power: 50),
  Enemy.new(name: "Emeraldia", defense_gem: EMERALD, attack_power: 50),
  Enemy.new(name: "Sapphiron", attack_gem: SAPPHIRE)
])
ROOM3   = Room.new(
  description: "Room 3",
  enemies: [
  Enemy.new(name: "Rubius", attack_gem: RUBY),
  Enemy.new(name: "Emeraldia", defense_gem: EMERALD),
  Enemy.new(name: "Sapphiron", attack_gem: SAPPHIRE)
])
ROOM4   = Room.new(
  description: "Room 4",
  enemies: [
    Enemy.new(name: "Rubius", attack_gem: RUBY),
    Enemy.new(name: "Emeraldia", defense_gem: EMERALD),
    Enemy.new(name: "Sapphiron", attack_gem: SAPPHIRE)
])

PATH = [[ROOM, ROOM2], [ROOM3, ROOM4]]

def start
  player_name = View.get_player_name
  View.greet(player_name)
  game = Game.new(player_name: player_name, starter_gems: STARTER_GEMS, path: PATH)
  play game
end

def play game
    game.player.add_to_inventory([OP]*20)
    game.path.each do |p|
      return game_over(game) if game.player.is_dead?
      index = View.display_room_menu(p)
      game.current_room = p[index]
      reset_turns(game)
      battle(game)
    end
end

def battle game
  until game.current_room.is_clear? || game.player.is_dead?
    View.display_room_status(game.current_room.enemies, game.player)
    sleep(0.2)
    if game.player_turn
      player_turn(game)
    elsif game.enemy_turn[:flag]
      enemy_turn(game, game.enemy_turn[:id])
    end
  end
end

def player_turn(game)

  outcome = game.player.apply_status_effects
  
  return if game.player.is_dead?
  
  View.display(outcome) if outcome
  
  if game.player.is_frozen?
    View.display_turn_skip_message(game.player.name)
    player_turn_switcher(game)
    View.wait()
    return
  end

  gem = View.gems_menu(game.player.inventory)

  if gem[:target] == nil
    player_turn_switcher(game)
    View.wait
    return
  elsif gem[:target] == :single
    target_id = View.target_menu(game.current_room.enemies, game.player)
    if target_id >= 0
      target = game.current_room.enemies[target_id]
      outcome = game.player.use_gem(gem[:name], target)
    elsif target_id == -1
      outcome = game.player.use_gem(gem[:name])
    end
  elsif gem[:target] == :aoe
    outcome = game.player.use_aoe_gem(gem[:name], game.current_room.enemies)
  end

  View.display(outcome)

  player_turn_switcher(game)
  View.display_room_status(game.current_room.enemies, game.player)
  View.wait()
end

def enemy_turn(game, id)

  game.current_room.enemies[id].reduce_cooldowns

  outcome = game.current_room.enemies[id].apply_status_effects
  View.display(outcome) if outcome

  if game.current_room.enemies[id].is_frozen?
    View.display_turn_skip_message(game.current_room.enemies[id].name)
    enemy_turn_switcher game
    View.wait
    return
  end

  outcome = AI.enemy_turn(game, id)
  View.display(outcome)
  
  return if game.player.is_dead?

  enemy_turn_switcher(game)
  View.display_room_status(game.current_room.enemies, game.player)
  View.wait
end

def enemy_turn_switcher(game)
  game.player_turn = true
  turn = game.enemy_turn[:id]
  game.enemy_turn[:id] = turn == game.current_room.enemies.size - 1 ? 0 : turn + 1
  game.enemy_turn[:flag] = false
end

def reset_turns(game)
  game.enemy_turn[:id] = 0
  game.enemy_turn[:flag] = false
  game.player_turn = true
end

def player_turn_switcher(game)
  unless game.player.is_hasted?
    game.player_turn = false
    game.enemy_turn[:flag] = true
  end
end

def game_over game
  choice = View.display_game_over
  case choice
  when "Restart"
    system("clear")
    player_name = game.player.name
    game = Game.new(player_name: player_name, starter_gems: STARTER_GEMS, path: PATH)
    play game
  when "Exit"
    View.exit
  end
end

start()