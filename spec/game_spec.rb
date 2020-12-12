require_relative "../game"

describe "Game instance" do

  it "creates player with default name if no name is given" do
    game = Game.new
    expect(game.player.name).to eq("Player")
  end

  it "adds 3 starter gems to player's inventory" do
    ruby      = CrystalGem.new("Ruby", "", proc {})
    sapphire  = CrystalGem.new("Sapphire", "", proc {})
    emerald   = CrystalGem.new("Clear Quartz", "", proc {})
    amethyst  = CrystalGem.new("Amethyst", "", proc {})
    game      = Game.new("Player", [ruby, sapphire, emerald, amethyst])
    expect(game.player.inventory.keys.size).to eq(3)
  end
end
