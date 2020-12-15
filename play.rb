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
  target: :aoe,
  description: "Deals damage and applies frozen status to all enemies",
  action: proc { |targets|
    targets.each_value { |t|
      t.damage(10); t.add_status(:frozen, {turns: 2})
    }
  }
)

STARTER_GEMS  = [RUBY, SAPPHIRE, EMERALD, AMETHYST]

ENEMY   = Enemy.new(name: "Rubius", attack_gem: RUBY)
ENEMY2  = Enemy.new(name: "Rubius", attack_gem: RUBY)
ROOM    = Room.new(enemies: [ENEMY, ENEMY2])

# def play
#     player_name = View.get_player_name
#     View.greet(player_name)
#     game = Game.new(player_name, STARTER_GEMS)
# end

def battle
  game = Game.new(player_name: "Globox", starter_gems: STARTER_GEMS, rooms: [ROOM])
  #AMETHYST.use_on(game.player)
  enemy_turn(game, 0)
end

def player_turn(game)
  View.display_room_status(game.current_room.enemies, game.player)
  
  game.player.apply_status_effects
  # skip turn if frozen
  if game.player.is_frozen?
    View.display_turn_skip_message
    return
  end

  #pick a gem to use
  gem = View.gems_menu(game.player.inventory)
  game.player.discard_gem(gem.name)

  #single target or aoe?
  if gem.target == :single
    target = View.target_menu(game.current_room.enemies, game.player)
    gem.use_on(game.current_room.enemies[target]) if target >= 0
    gem.use_on(game.player) if target == -1
  else
    gem.use_on(game.current_room.enemies)
  end

  View.display_room_status(game.current_room.enemies, game.player)
end

def enemy_turn(game, id)

  game.current_room.enemies[id].reduce_cooldowns

  outcome = game.current_room.enemies[id].apply_status_effects
  View.display(outcome) if outcome
  
  if game.current_room.enemies[id].is_frozen?
    View.display_turn_skip_message(game.current_room.enemies[id].name)
    return
  end

  outcome = AI.enemy_turn(game, id)
  View.display outcome
  View.display_room_status(game.current_room.enemies, game.player)
end

battle()