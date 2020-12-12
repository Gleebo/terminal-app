require_relative "./model"

class Game
    attr_reader :player
    def initialize(player_name = "Player", starter_gems = [])
      @player = Player.new(player_name)
      @starter_gems = starter_gems
      player.add_to_inventory(get_random_starter_gems)
    end

    private
    def get_random_starter_gems
      @starter_gems.sample(3)
    end
end
