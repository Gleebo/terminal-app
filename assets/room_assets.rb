require_relative "./enemy_assets"
require_relative "./gem_assets"
require_relative "../models/room"

module RoomAssets
  def self.right1
    geode = GemAssets.geode
    malachite = GemAssets.malachite
    ruby = GemAssets.ruby
    Room.new(
      description: "A room with a depiction of Quartz above the entrance",
      enemies: [
        EnemyAssets.geodite,
        EnemyAssets.geodite
      ],
      reward: {
        geode.name => {gem: geode, quantity: 5},
        malachite.name => {gem: malachite, quantity: 3},
        ruby.name => {gem: ruby, quantity: 2}
      }
    )
  end

  def self.left1
    geode = GemAssets.geode
    malachite = GemAssets.malachite
    aquamarine = GemAssets.aquamarine
    Room.new(
      description: "A room with a depiction of Heliodor above the entrance",
      enemies: [
        EnemyAssets.geodite,
        EnemyAssets.malachita
      ],
      reward: {
        geode.name => {gem: geode, quantity: 5},
        malachite.name => {gem: malachite, quantity: 3},
        aquamarine.name => {gem: aquamarine, quantity: 2}
      }
    )
  end
  
  def self.right2
    amethyst = GemAssets.amethyst
    geode = GemAssets.geode
    emerald = GemAssets.emerald
    ruby = GemAssets.ruby
    opal = GemAssets.opal
    Room.new(
      description: "A room with a depiction of Alexandrite above the entrance",
      enemies: [
        EnemyAssets.geodite,
        EnemyAssets.malachita,
        EnemyAssets.rubius,
      ],
      reward: {
        geode.name => {gem: geode, quantity: 5},
        amethyst.name => {gem: amethyst, quantity: 2},
        emerald.name => {gem: emerald, quantity: 1},
        ruby.name => {gem: ruby, quantity: 2},
        opal.name => {gem: opal, quantity: 1}
      }
    )
  end

  def self.left2
    amethyst = GemAssets.amethyst
    geode = GemAssets.geode
    emerald = GemAssets.emerald
    sapphire = GemAssets.sapphire
    obsidian = GemAssets.obsidian
    Room.new(
      description: "A room with a depiction of Rose Quartz above the entrance",
      reward: {
        geode.name => {gem: geode, quantity: 5},
        amethyst.name => {gem: amethyst, quantity: 2},
        emerald.name => {gem: emerald, quantity: 1},
        sapphire.name => {gem: sapphire, quantity: 2},
        obsidian.name => {gem: obsidian, quantity: 1}
      }
    )
  end
  
  def self.right3
    diamond = GemAssets.diamond

    Room.new(
      description: "A room with a depiction of Onyx above the entrance",
      enemies: [
        EnemyAssets.sapphiron,
        EnemyAssets.emeraldia,
        EnemyAssets.amerub,
      ],
      reward: {
        diamond.name => {gem: diamond, quantity: 1}
      }
    )
  end

  def self.left3
    pink_diamond = GemAssets.pink_diamond
    Room.new(
      description: "A room with a depiction of Sapphire above the entrance",
      enemies: [
        EnemyAssets.amethystius,
        EnemyAssets.sapphiron,
        EnemyAssets.aquathyst
      ],
      reward: {
        pink_diamond.name => {gem: pink_diamond, quantity: 1}
      }
    )
  end
  
end