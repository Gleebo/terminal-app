require "./model"
require "./game"

describe "The player instance" do
    NAME = "Globox"
    it "remembers player's name" do
        player = Player.new(NAME)
        expect(player.name).to eq("Globox")
    end
    it "reduces player's hp" do
        player = Player.new(NAME)
        player.damage(20)
        expect(player.hp).to eq(80)
    end
    it "heals player's hp" do
        player = Player.new(NAME)
        player.damage(80)
        player.heal(20)
        expect(player.hp).to eq(40)
        player.heal(100)
        expect(player.hp). to eq(100)
    end
    it "adds items to the inventory" do
        player = Player.new(NAME)
        player.add_to_inventory("ruby")
        expect(player.inventory.length).to eq(1)
        player.add_to_inventory(["sapphire", "emerald"])
        expect(player.inventory.length).to eq(3)
    end
end
