require_relative "./character.rb"

class Player < Character
  attr_reader :inventory
  def initialize(name: "Player", total_hp: 250)
      super(name: name, total_hp: total_hp)
      @inventory = {}
  end

  def add_to_inventory(gems)
    gems.each do |k, v|
      if @inventory[k]
        @inventory[k][:quantity] += v[:quantity]
        next
      end
      @inventory[k] = v
    end
  end

  def use_gem(gem_name, target = self)
    outcome = @inventory[gem_name][:gem].action.call(target)
    discard_gem(gem_name)
    "#{@name} uses #{gem_name}. #{outcome}"
  end

  def use_aoe_gem(gem_name, targets)
    outcome = @inventory[gem_name][:gem].action.call(targets)
    discard_gem(gem_name)
    "#{@name} uses #{gem_name}:\n#{outcome}"
  end

  private
  def discard_gem(gem_name)
    @inventory[gem_name][:quantity] -= 1
    @inventory.delete_if { |k, v| v[:quantity] == 0 }
  end
end
