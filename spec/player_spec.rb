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
        expect(player.hp).to eq(230)
    end

    it "heals hp" do
        player = Player.new
        player.damage(80)
        player.heal(20)
        expect(player.hp).to eq(190)
    end

    it "adds items to the inventory" do
        player  = Player.new
        gem     = CrystalGem.new
        player.add_to_inventory({gem.name => {gem: gem, quantity: 1}})
        expect(player.inventory).to have_key("gem")
    end

    it "takes no damage when protected" do
      player = Player.new
      player.add_status(:protected, {turns: 1})
      player.damage(20)
      expect(player.hp).to eq(250)
    end

    it "takes damage instead of healing when cursed" do
      player = Player.new
      player.add_status(:cursed, {turns: 1})
      player.heal(50)
      expect(player.hp).to eq(200)
    end

    it "gets affected by status effects" do
      player = Player.new
      player.add_status(:burning, { turns: 2, damage: 20 })
      player.add_status(:regenerating, {turns: 2, heal: 10})
      outcome = player.apply_status_effects
      expect(player.hp).to eq(240)
      expect(outcome).to eq("Burning status effect: Player takes 20 damage. Regenerating status effect: Player heals 10 hp ")
    end

    it "can use gem on themselve" do
      player = Player.new
      player.damage(50)
      emerald = CrystalGem.new(name: "emerald", action: proc { |target| target.heal(20)})
      player.add_to_inventory({emerald.name => {gem: emerald, quantity: 1}})
      outcome = player.use_gem("emerald")
      expect(player.hp).to eq(220)
      expect(outcome).to eq("Player uses emerald. Player heals 20 hp")
    end
end
