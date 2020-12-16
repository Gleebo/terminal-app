require_relative "../models/enemy"
require_relative "./gem_assets"
module EnemyAssets
  def self.rubius
    Enemy.new(name: "Rubius", attack_gem: GemAssets.ruby, attack_power: 20)
  end
  
  def self.emeraldia
    Enemy.new(name: "Emeraldia", defense_gem: GemAssets.emerald, attack_power: 20)
  end

  def self.sapphiron
    Enemy.new(name: "Sapphiron", attack_gem: GemAssets.sapphire, attack_power: 20)
  end

  def self.amerub
    Enemy.new(name: "Amerub", attack_gem: GemAssets.ruby, defense_gem: GemAssets.amethyst, attack_power: 30)
  end
end