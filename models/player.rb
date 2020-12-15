require_relative "./character.rb"

class Player < Character
    attr_reader :inventory
    def initialize(name: "Player")
        super(name: name)
        @inventory = {}
    end

    def add_to_inventory(gem)
      gem.each do |g|
        if @inventory[g.name]
          @inventory[g.name][:quantity] += 1
          next
        end
        @inventory[g.name] = {gem: g, quantity: 1}
      end
    end

    def use_gem(gem_name, target = self)
      outcome = @inventory[gem_name][:gem].action.call(target)
      discard_gem(gem_name)
      "#{@name} uses #{gem_name} on #{outcome}"
    end

    def use_aoe_gem(gem_name, targets)
      outcome = @inventory[gem_name][:gem].action.call(targets)
      "#{@name} uses #{gem_name} on:\n#{outcome}"
    end

    private
    def discard_gem(gem_name)
      @inventory[gem_name][:quantity] -= 1
      @inventory.delete_if { |k, v| v[:quantity] == 0 }
    end
end
