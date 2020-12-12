require_relative "../models/enemy"
require_relative "../models/player"
require_relative "../models/gem"

describe "Enemy" do

  it "has powers" do
    enemy = Enemy.new
    expect(enemy.attack(enemy)).to eq("SHINE!")
  end

  it "can damage player" do
    player  = Player.new
    ruby    = CrystalGem.new(action: proc { |target| target.damage(10) })
    enemy   = Enemy.new(gem: ruby)
    enemy.attack(player)
    expect(player.hp).to eq(90)
  end
end
