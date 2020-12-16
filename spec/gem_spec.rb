require_relative "../models/gem"
require_relative "../models/player"
require_relative "../models/enemy"
require_relative "../models/room"

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
    subject.use_on enemy
    expect(enemy.hp).to eq(80)
  end

  it "modifies status when used" do
    enemy = Enemy.new
    sapphire = CrystalGem.new(action: proc { |target| target.add_status(:frozen, {turns: 2}); target.damage(10) })
    sapphire.use_on enemy
    expect(enemy.hp).to eq(90)
    expect(enemy.status).to include(:frozen)
  end

  it "affects multiple targets if target is AOE" do
    enemies = [Enemy.new, Enemy.new]
    room = Room.new(enemies: enemies)
    lapis_lazuli = CrystalGem.new(
      target: :aoe,
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += "#{t.damage(10)}. #{t.add_status(:frozen, {turns: 2})}\n"
        }
      },
    )
    outcome = lapis_lazuli.use_on(room.enemies)
    expect(room.enemies).to satisfy do |enemies|
      enemies.reduce(true) do |acc, enemy|
        acc &&= (enemy.hp == 90 && enemy.status.has_key?(:frozen))
      end
    end
  end
end
