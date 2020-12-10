require "./player"
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
end