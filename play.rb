require_relative "./view"
require_relative "./game"
require_relative "./models/room"
require_relative "./models/enemy"
require_relative "./models/gem"

RUBY          = CrystalGem.new(name: "Ruby", description:"Deal fire damage to a single target", action: proc { |target| target.damage(20) })
SAPPHIRE      = CrystalGem.new(name: "Sapphire", description: "Deal slight damage and freeze a single target", action: proc { |target| target.damage(10) })
EMERALD       = CrystalGem.new(name: "Clear Quartz", description: "Heal a single target", action: proc { |target| target.heal(25) })
AMETHYST      = CrystalGem.new(name: "Amethyst", description: "Protects a single target from 1 instance of damage", action: proc {|target| target.protect})
STARTER_GEMS  = [RUBY, SAPPHIRE, EMERALD, AMETHYST]

ENEMY = Enemy.new(name: "Rubius", gem: RUBY)
ROOM  = Room.new(enemies: [ENEMY, ENEMY])
# def play
#     player_name = View.get_player_name
#     View.greet(player_name)
#     game = Game.new(player_name, STARTER_GEMS)
# end

def battle
  game = Game.new(player_name: "Globox", starter_gems: STARTER_GEMS, rooms: [ROOM])
  gem_to_use = View.gems_menu(game.player.inventory)
  game.player.discard_gem(gem_to_use.name)
  View.target_menu(game.current_room.enemies)
end
battle()
