require_relative "../models/enemy"
require_relative "../models/player"
require_relative "../models/gem"

describe "Player" do

    it "remembers name" do
        player = Player.new(name: "Globox")
        expect(player.name).to eq("Globox")
    end

    it "reduces hp" do
        player = Player.new
        player.damage(20)
        expect(player.hp).to eq(80)
    end

    it "heals hp" do
        player = Player.new
        player.damage(80)
        player.heal(20)
        expect(player.hp).to eq(40)
        player.heal(100)
        expect(player.hp). to eq(100)
    end

    it "adds items to the inventory" do
        player  = Player.new
        gem     = CrystalGem.new
        player.add_to_inventory([gem])
        expect(player.inventory).to have_key("gem")
        ruby    = CrystalGem.new(name: "ruby", description: "Incinerate", action: proc {})
        emerald = CrystalGem.new(name: "emerald", description: "Heal", action: proc {})
        player.add_to_inventory([ruby, emerald])
        expect(player.inventory).to include("ruby", "emerald")
        player.add_to_inventory([ruby, ruby, ruby])
        expect(player.inventory["ruby"][:quantity]).to eq(4)
    end
end
