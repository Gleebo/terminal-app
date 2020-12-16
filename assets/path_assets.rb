require_relative "./room_assets"

module PathAssets
  def self.path 
    [
      [RoomAssets.room1, RoomAssets.room2],
      [RoomAssets.room5, RoomAssets.safe_room],
      [RoomAssets.room3, RoomAssets.room4]
    ]
  end
end