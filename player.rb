class Player
    attr_reader :name
    attr_accessor :hp
    def initialize(name = "Player")
        @hp = 100
        @name = name
    end

    def heal(amount)
        @hp += amount
        @hp = 100 if @hp > 100
    end

    def damage(amount)
        @hp -= amount
        @hp = 0 if @hp < 0 
    end
end