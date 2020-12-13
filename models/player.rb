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

    def discard_gem(gem_name)
      @inventory[gem_name][:quantity] -= 1
      @inventory.delete_if { |k, v| v[:quantity] == 0 }
    end
end
