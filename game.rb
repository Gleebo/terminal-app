require_relative "./player"

class Game
    attr_reader :player
    def initialize(player_name)
        @player = Player.new(player_name)
        starter_gems = get_random_starter_gems
        @player.add_to_inventory(starter_gems)
    end
    
    private 
    def get_random_starter_gems
        gems = ["ruby", "emerald", "malachite", "sapphire", "pearl"]
        gems.sample(3)
    end
end