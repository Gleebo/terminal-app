require_relative "../models/enemy"
require_relative "./gem_assets"
module EnemyAssets
  def self.rubius
    Enemy.new(name: "Rubius", attack_gem: GemAssets.ruby, attack_power: 20, total_hp: 60)
  end

  def self.emeraldia
    Enemy.new(name: "Emeraldia", defense_gem: GemAssets.emerald, attack_power: 20, total_hp: 60)
  end

  def self.sapphiron
    Enemy.new(name: "Sapphiron", attack_gem: GemAssets.sapphire, attack_power: 20, total_hp: 60)
  end

  def self.amerub
    Enemy.new(name: "Amerub", attack_gem: GemAssets.ruby, defense_gem: GemAssets.amethyst, attack_power: 30, total_hp: 70)
  end

  def self.geodite
    Enemy.new(name: "Geodite", attack_gem: GemAssets.geode, attack_power: 20, total_hp: 50)
  end

  def self.malachita
    Enemy.new(name: "Malachita", defense_gem: GemAssets.malachite, attack_power: 20, total_hp: 50)
  end

  def self.aquamarina
    Enemy.new(name: "Aquamarina", attack_gem: GemAssets.aquamarine, attack_power: 10, total_hp: 60)
  end

  def self.amethystius
    Enemy.new(
      name: "Amethistius",
      defense_gem: GemAssets.amethyst,
      attack_power: 20,
      total_hp: 60
    )
  end

  def self.aquathyst
    Enemy.new(
      name: "Aquastius",
      attack_gem: GemAssets.aquamarine,
      defense_gem: GemAssets.amethyst,
      attack_power: 30,
      total_hp: 70
    )
  end
end