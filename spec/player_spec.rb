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

    it "takes no damage when protected" do
      player = Player.new
      player.add_status(:protected, {turns: 1})
      player.damage(20)
      expect(player.hp).to eq(100)
    end

    it "takes damage instead of healing when cursed" do
      player = Player.new
      player.add_status(:cursed, {turns: 1})
      player.heal(50)
      expect(player.hp).to eq(50)
    end

    it "gets affected by status effects" do
      player = Player.new
      player.add_status(:burning, { turns: 2, damage: 20 })
      player.add_status(:regenerating, {turns: 2, heal: 10})
      player.apply_status_effects
      expect(player.hp).to eq(90)
    end
end
