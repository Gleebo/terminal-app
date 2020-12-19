require_relative "./room_assets"

module PathAssets
  def self.path 
    [
      [RoomAssets.right1, RoomAssets.left1],
      [RoomAssets.right2, RoomAssets.left2],
      [RoomAssets.right3, RoomAssets.left3]
    ]
  end
end
