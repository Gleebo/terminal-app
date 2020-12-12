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

  it "adds 3 starter gems to player's inventory" do
    ruby      = CrystalGem.new(name: "Ruby")
    sapphire  = CrystalGem.new(name: "Sapphire")
    emerald   = CrystalGem.new(name: "Emerald")
    amethyst  = CrystalGem.new(name: "Amethyst")
    game      = Game.new(starter_gems: [ruby, sapphire, emerald, amethyst])
    expect(game.player.inventory.keys.size).to eq(3)
  end

  it "has rooms" do
    rooms = []
    10.times do
      rooms << {sign: "ruby", enemies: ["Rubius", "Rubius"]}
    end
    game = Game.new(rooms: rooms)
    expect(game.rooms.length).to eq(10)
  end
end
