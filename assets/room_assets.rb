require_relative "./enemy_assets"
require_relative "./gem_assets"
require_relative "../models/room"

module RoomAssets
  def self.room1
    Room.new(
      description: "A room with a depiction of Ruby above the entrance",
      enemies: [
        EnemyAssets.rubius,
        EnemyAssets.rubius
      ]
    )
  end

  def self.room2
    Room.new(
      description: "A room with a depiction of Heliodor above the entrance",
      enemies: [
        EnemyAssets.rubius,
        EnemyAssets.emeraldia
      ]
    )
  end

  def self.room3
    Room.new(
      description: "A room with a depiction of Alexandrite above the entrance",
      enemies: [
        EnemyAssets.sapphiron,
        EnemyAssets.rubius,
      ]
    )
  end

  def self.room4
    Room.new(
      description: "A room with a depiction of Onyx above the entrance",
      enemies: [
        EnemyAssets.emeraldia,
        EnemyAssets.rubius,
        EnemyAssets.sapphiron
      ]
    )
  end

  def self.room5
    Room.new(
      description: "A room with a depiction of Sapphire above the entrance",
      enemies: [
        EnemyAssets.sapphiron,
        EnemyAssets.sapphiron
      ]
    )
  end
  
  def self.safe_room
    Room.new(
      description: "A room with a depiction of Rose Quartz above the entrance",
      reward: [
        GemAssets.ruby,
        GemAssets.emerald
      ]*3
    )
  end
end