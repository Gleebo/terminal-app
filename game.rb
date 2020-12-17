require_relative "./models/player"

class Game
    attr_reader :player, :rooms, :path
    attr_accessor :player_turn, :enemy_turn, :current_room
    def initialize(player_name: "Player", starter_gems: [], path: [])
      @path         = path
      @rooms        = path[0]
      @current_room = @rooms[0]
      @player       = Player.new(name: player_name)
      @starter_gems = starter_gems
      @player_turn  = true
      @enemy_turn   = {id: 0, flag: true}
      @player.add_to_inventory(get_random_starter_gems)
    end

    private
    def get_random_starter_gems
      @starter_gems.to_a.sample(6).to_h
    end
end
