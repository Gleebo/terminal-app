require "./player"
require "./game"

describe "The player" do
    it "remembers player's name" do
        name = "Globox"
        player = Player.new(name)
        expect(player.name).to eq("Globox")
    end
    it "creates a default name if none is given" do
        anon = Player.new
        expect(anon.name).to eq("Player")
    end
    it "reduces player's hp" do
        player = Player.new
        player.damage(20)
        expect(player.hp).to eq(80)
    end
    it "heals player's hp" do
        player = Player.new
        player.damage(80)
        player.heal(20)
        expect(player.hp).to eq(40)
        player.heal(100)
        expect(player.hp). to eq(100)
    end
    it "adds items to the inventory" do
        player = Player.new
        player.add_to_inventory("ruby")
        expect(player.inventory.length).to eq(1)
        player.add_to_inventory(["sapphire", "emerald"])
        expect(player.inventory.length).to eq(3)
    end
    it "creates and adds starter gems" do
        player = Player.new
        game = Game.new(player)
        expect(player.inventory.size).to eq(3)
    end
end