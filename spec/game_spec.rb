require_relative "../game"
require_relative "../models/room"
require_relative "../models/player"
require_relative "../models/enemy"
require_relative "../models/gem"

describe "Game" do

  it "creates player with default name if no name is given" do
    game = Game.new
    expect(game.player.name).to eq("Player")
  end

  it "changes enemy turn" do
    game = Game.new
    game.enemy_turn[:id] = 2
    expect(game.enemy_turn[:id]).to eq(2)
  end
end
