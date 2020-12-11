class Player
    attr_reader :name, :inventory
    attr_accessor :hp
    def initialize(name = "Player")
        @hp = 100
        @name = name
        @inventory = []
    end

    def heal(amount)
        @hp += amount
        @hp = 100 if @hp > 100
    end

    def damage(amount)
        @hp -= amount
        @hp = 0 if @hp < 0 
    end

    def add_to_inventory(item)
        if item.is_a?(Array)
            @inventory += item
        else 
            @inventory << item
        end
    end
end