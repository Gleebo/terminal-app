require_relative "../game"

describe "Game instance" do
  it "creates player with default name if no name is given" do
    game = Game.new
    expect(game.player.name).to eq("Player")
  end
  it "adds 3 starter gems to player's inventory" do
    game = Game.new
    expect(game.player.inventory.size).to eq(3)
  end
end
