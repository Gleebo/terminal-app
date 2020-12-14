require_relative "./view"
require_relative "./game"
require_relative "./models/room"
require_relative "./models/enemy"
require_relative "./models/gem"

RUBY = CrystalGem.new(
  name: "Ruby",
  description:"Deal fire damage to a single target",
  action: proc { |target| target.damage(20); target.add_status(:burning, {turns: 2, damage: 5})}
)

SAPPHIRE = CrystalGem.new(
  name: "Sapphire",
  description: "Deal 10 damage and apply frozen status",
  action: proc { |target| target.damage(10); target.add_status(:frozen, {turns: 1}) }
)

EMERALD = CrystalGem.new(
  name: "Emerald",
  description: "Heal a single target for 25 and apply regenerating status",
  action: proc { |target| target.heal(25); target.add_status(:regenerating, {turns: 2, heal: 10}) }
)

AMETHYST = CrystalGem.new(
  name: "Amethyst",
  description: "Protects a single target from 1 instance of damage",
  action: proc {|target| target.add_status(:protected, {turns: 1})}
)

STARTER_GEMS  = [RUBY, SAPPHIRE, EMERALD, AMETHYST]

ENEMY   = Enemy.new(name: "Rubius", gem: RUBY)
ENEMY2  = Enemy.new(name: "Rubius", gem: RUBY)
ROOM    = Room.new(enemies: [ENEMY, ENEMY2])

# def play
#     player_name = View.get_player_name
#     View.greet(player_name)
#     game = Game.new(player_name, STARTER_GEMS)
# end

def battle
  game = Game.new(player_name: "Globox", starter_gems: STARTER_GEMS, rooms: [ROOM])
  SAPPHIRE.use_on(game.player)
  RUBY.use_on(game.player)
  player_turn(game)
end

def player_turn(game)
  View.display_room_status(game.current_room.enemies, game.player)
  if game.player.is_frozen?
    View.display_turn_skip_message
    return
  end
  game.player.apply_status_effects
  gem = View.gems_menu(game.player.inventory)
  game.player.discard_gem(gem.name)
  target = View.target_menu(game.current_room.enemies)
  gem.use_on(game.current_room.enemies[target])
  View.display_room_status(game.current_room.enemies, game.player)
end

battle()
