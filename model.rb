class Character
  attr_reader :name, :hp

  def initialize(name)
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

class Player < Character
    attr_reader :inventory
    def initialize(name)
        super(name)
        @inventory = []
    end

    def add_to_inventory(item)
        if item.is_a?(Array)
            @inventory += item
        else
            @inventory << item
        end
    end
end

class Enemy < Character
  def initialize(name, type, power)
    super(name)
    @type   = type
    @power  = power
  end
end
