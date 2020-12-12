require_relative "../models/gem"
require_relative "../models/player"
require_relative "../models/enemy"

describe "Gem" do
  subject {
    CrystalGem.new(
      name: "Ruby",
      description: "Incinerate your enemies!",
      action: proc { |target| target.damage(20) }
    )
  }

  it "has a name" do
    expect(subject.name).to eq("Ruby")
  end

  it "has a description" do
    expect(subject.description).to eq("Incinerate your enemies!")
  end

  it "performs an action when used" do
    enemy = Enemy.new
    subject.use(enemy)
    expect(enemy.hp).to eq(80)
  end

  it "modifies status when used" do
    enemy = Enemy.new
    sapphire = CrystalGem.new(action: proc { |target| target.add_status(:frozen); target.damage(10) })
    sapphire.use(enemy)
    expect(enemy.hp).to eq(90)
    expect(enemy.status).to include(:frozen)
  end
end
