require_relative "./character.rb"

class Player < Character
    attr_reader :inventory
    def initialize(name: "Player")
        super(name: name)
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
