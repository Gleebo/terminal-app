class Character
  attr_reader :name, :hp, :status

  def initialize(name: "Default Name")
    @name   = name
    @hp     = 100
    @status = {}
  end

  def heal(amount)
      @hp += amount
      @hp = 100 if @hp > 100
  end

  def damage(amount)
      @hp -= amount
      @hp = 0 if @hp < 0
  end

  def add_status(status)
    @status[status] = true
  end

end
