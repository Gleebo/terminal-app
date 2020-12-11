require "./view"
require "./player"
require "./game"

def play
    player_name = View.get_player_name
    View.greet(player_name)
    game = Game.new(player_name)
    View.display_inventory(game.player.inventory)
end

play