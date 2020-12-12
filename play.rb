require_relative "./view"
require_relative "./game"

require_relative "./gem"
RUBY          = CrystalGem.new("Ruby", "Deal fire damage to a single target", proc { |target| target.damage(20) })
SAPPHIRE      = CrystalGem.new("Sapphire", "Deal slight damage and freeze a single target", proc { |target| target.damage(10) })
EMERALD       = CrystalGem.new("Clear Quartz", "Heal a single target", proc { |target| target.heal(25) })
AMETHYST      = CrystalGem.new("Amethyst", "Protects a single target from 1 instance of damage", proc {|target| target.protect})
STARTER_GEMS  = [RUBY, SAPPHIRE, EMERALD, AMETHYST]

def play
    player_name = View.get_player_name
    View.greet(player_name)
    game = Game.new(player_name, STARTER_GEMS)
end

play()
