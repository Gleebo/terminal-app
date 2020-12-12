class CrystalGem
  attr_reader :name, :description, :action
  def initialize(name: "gem", description: "shiny gem", action: proc {"SHINE!"})
    @name = name
    @description = description
    @action = action
  end
  def use(target)
    @action.call(target)
  end
end
