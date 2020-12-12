require_relative "../model"
require_relative "../gem"

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
        player  = Player.new(NAME)
        gem     = CrystalGem.new("a gem", "it's shiny", proc {})
        player.add_to_inventory(gem)
        expect(player.inventory).to have_key("a gem")
        ruby    = CrystalGem.new("ruby", "Incinerate", proc {})
        emerald = CrystalGem.new("emerald", "Heal", proc {})
        player.add_to_inventory([ruby, emerald])
        expect(player.inventory).to include("ruby", "emerald")
        player.add_to_inventory([ruby, ruby, ruby])
        expect(player.inventory["ruby"]).to eq(4)
    end
end
