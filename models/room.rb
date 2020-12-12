class Room
  attr_reader :description, :enemies

  def initialize(enemies: [], description: "a room")
    @description  = description
    @enemies      = enemies
    @turns        = []
  end

end
