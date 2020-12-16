class CrystalGem
  attr_reader :name, :description, :action, :target
  def initialize(name: "gem", description: "shiny gem", action: proc {"SHINE!"}, target: :single)
    @name = name
    @description = description
    @action = action
    @target = target
  end

  def use_on target
    @action.call(target)
  end
end
