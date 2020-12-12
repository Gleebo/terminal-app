require_relative "../gem"
require_relative "../model"

describe "Gem" do
  subject {
    CrystalGem.new("Ruby", "Incinerate your enemies!", proc { |target| target.damage(20) } )
  }

  it "has a name" do
    expect(subject.name).to eq("Ruby")
  end

  it "has a description" do
    expect(subject.description).to eq("Incinerate your enemies!")
  end

  it "performs an action when used" do
    enemy = Enemy.new("Amerald", "regular", ["amethyst", "emerald"])
    subject.use(enemy)
    expect(enemy.hp).to eq(80)
  end
end
