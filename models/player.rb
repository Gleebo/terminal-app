require_relative "./character.rb"

class Player < Character
    attr_reader :inventory
    def initialize(name: "Player")
        super(name: name)
        @inventory = {}
    end

    def add_to_inventory(gem)
      if gem.is_a?(Array)
        gem.each do |g|
          @inventory[g.name] = {gem: g, quantity: 1}
        end
      else
        @inventory[g.name][:quantity] += 1
      end
    end

    def discard_gem(gem_name)
      @inventory[gem_name][:quantity] -= 1
      @inventory.delete_if { |k, v| v[:quantity] == 0 }
    end
end
