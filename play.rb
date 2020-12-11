require "./view"
require "./player"
require "./game"
def play
    name = View.get_player_name
    View.greet(name)
    player = Player.new(name)
    game = Game.new(player)
end