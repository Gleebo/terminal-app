class Room
  attr_reader :description

  def initialize(enemies: [], description: "a room")
    @description  = description
    @enemies      = enemies
    @turns        = []
  end

end
