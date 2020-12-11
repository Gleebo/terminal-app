require_relative "../model"

describe "Enemy" do
  it "has powers" do
    enemy = Enemy.new("Malarub", "regular", ["malachite", "ruby"])
    expect(enemy.powers.size).to eq(2)
  end
end
