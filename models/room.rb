class Room
  attr_reader :description, :enemies

  def initialize(enemies: [], description: "a room")
    @description  = description
    @enemies = {}
    enemy_hash(enemies)
    @turns        = []
  end

  private
  def enemy_hash(enemies)
    enemies.each_with_index { |enemy, index| @enemies[index] = enemy }
  end
end
