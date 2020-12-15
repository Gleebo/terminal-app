class Room
  attr_reader :description, :enemies

  def initialize(enemies: [], description: "a room")
    @description  = description
    @enemies      = enemies
    #enemy_hash(enemies)
    @turns        = []
  end

  def get_wounded_id
    @enemies.index { |enemy| enemy.below_half_hp? }
  end
  
  def is_clear?
    enemies.all? {|enemy| enemy.is_dead? } 
  end

  private
  def enemy_hash(enemies)
    enemies.each_with_index { |enemy, index| @enemies[index] = enemy }
  end
end
