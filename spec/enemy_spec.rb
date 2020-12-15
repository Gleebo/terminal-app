require_relative "../models/enemy"
require_relative "../models/player"
require_relative "../models/gem"

describe "Enemy" do

  it "has powers" do
    enemy = Enemy.new
    expect(enemy.attack(enemy)).to eq("Enemy attacks Enemy and deals 10 damage")
  end

  it "can damage player" do
    player  = Player.new
    enemy = Enemy.new
    enemy.attack(player)
    expect(player.hp).to eq(90)
  end

  it "returns outcome string" do
    player = Player.new
    sapphire = CrystalGem.new(
      name: "Sapphire",
      description: "Deal damage and apply frozen status to a single target",
      action: proc { |target|
        "#{target.damage(10)}. #{target.add_status(:frozen, {turns: 1})}"
      }
    )
    enemy = Enemy.new(attack_gem: sapphire)
    outcome = enemy.use_attack_skill(player)
    expect(outcome).to eq("Enemy uses the power of Sapphire on Player and deals 10 damage. Player is now affected by frozen status")
  end
end
