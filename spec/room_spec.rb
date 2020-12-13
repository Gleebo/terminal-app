require_relative "../models/room"
require_relative "../models/enemy"

describe "Room" do
  it "creates a list of enemies with ids" do
    enemy = Enemy.new
    enemies = [enemy, enemy]
    room = Room.new(enemies: enemies)
    expect(room.enemies.keys.size).to eq(2)
  end
end
