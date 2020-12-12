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
        @inventory = Hash.new(0)
    end

    def add_to_inventory(gem)
      if gem.is_a?(Array)
        gem.each { |g| @inventory[g.name] += 1 }
      else
        @inventory[gem.name] += 1
      end
    end
end

class Enemy < Character
  attr_reader :powers, :type
  def initialize(name, type, powers)
    super(name)
    @type   = type
    @powers  = powers
  end
end
