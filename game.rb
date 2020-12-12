require_relative "./models/player"

class Game
    attr_reader :player, :rooms, :current_room

    def initialize(player_name: "Player", starter_gems: [], rooms: [])
      @rooms = rooms
      @current_room = @rooms[0]
      @player = Player.new(name: player_name)
      @starter_gems = starter_gems
      player.add_to_inventory(get_random_starter_gems)
    end

    private
    def get_random_starter_gems
      @starter_gems.sample(3)
    end
end
