require_relative "../models/room"
require_relative "../models/enemy"

describe "Room" do
  it "creates a list of enemies with ids" do
    enemy = Enemy.new
    enemies = [enemy, enemy]
    room = Room.new(enemies: enemies)
    expect(room.enemies.size).to eq(2)
  end
  
  it "notifies if any enemy is below 50% hp" do
    enemy   = Enemy.new
    enemy.damage(60)
    enemies = [enemy, Enemy.new]
    room    = Room.new(enemies: enemies)
    expect(room.get_wounded_id).to eq(0)
  end

end
