require_relative "./gem"
require_relative "./character"

class Enemy < Character
  attr_reader :type
  def initialize(name: "Enemy", type: "regular", gem: CrystalGem.new )
    super(name: name)
    @type   = type
    @power = gem.action
  end

  def attack(target)
    @power.call(target)
  end
end
