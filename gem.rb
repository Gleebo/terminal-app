class CrystalGem
  attr_reader :name, :description, :action
  def initialize(name, description, action)
    @name = name
    @description = description
    @action = action
  end
  def use(target)
    @action.call(target)
  end
end
