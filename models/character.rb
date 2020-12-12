class Character
  attr_reader :name, :hp

  def initialize(name: "Default Name")
    @name = name
    @hp   = 100
  end

  def heal(amount)
      @hp += amount
      @hp = 100 if @hp > 100
  end

  def damage(amount)
      @hp -= amount
      @hp = 0 if @hp < 0
  end
end
