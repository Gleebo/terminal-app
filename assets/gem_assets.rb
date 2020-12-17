require_relative "../models/gem"

module GemAssets
  def self.geode
    CrystalGem.new(
      name: "Geode",
      description: "Deal damage to a single target",
      action: proc { |target| 
        target.damage(25)
      }
    )
  end

  def self.ruby 
    CrystalGem.new(
      name: "Ruby",
      description:"Deal some damage and apply burning status to a single target",
      action: proc { |target|
        "#{target.damage(25)}. #{target.add_status(:burning, {turns: 3, damage: 5})}"
      }
    )
  end

  def self.garnet
    CrystalGem.new(
      name: "Garnet",
      description: "Deal heavy damage to a target and apply burning status effect",
      action: proc { |target| 
        "#{target.damage(40)}. #{target.add_status(:brning, {turns: 3, damage: 10})}"
      }
    )
  end

  def self.spinel
    CrystalGem.new(
      name: "Spinel",
      description: "Deal damage and apply burning status to all enemies",
      target: :aoe,
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += " > #{t.damage(30)}. #{t.add_status(:burning, {turns: 3, damage: 10})}\n"
        }
      }
    )
  end
  
  def self.aquamarine
    CrystalGem.new(
      name: "Aquamarine",
      description: "Deal damage and apply frozen status to a single target",
      action: proc { |target| 
        "#{target.damage(25)}. #{target.add_status(:frozen, {turns: 1})}"
      }
    )
  end

  def self.sapphire
    CrystalGem.new(
      name: "Sapphire",
      description: "Deal damage and apply frozen status to a single target",
      action: proc { |target| 
        "#{target.damage(40)}. #{target.add_status(:frozen, {turns: 2})}"
      }
    )
  end
  
  def self.lapis_lazuli
    CrystalGem.new(
      name: "Lapis Lazuli",
      target: :aoe,
      description: "Deals damage and applies frozen status to all enemies",
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += " > #{t.damage(30)}. #{t.add_status(:frozen, {turns: 2})}\n"
        }
      }
    )
  end

  def self.malachite
    CrystalGem.new(
      name: "Malachite",
      description: "Heal a single target for a bit of hp",
      action: proc { |target| 
        target.heal(25)
      }
    )
  end
  
  def self.emerald
    CrystalGem.new(
      name: "Emerald",
      description: "Heal and apply regenerating status to a single target",
      action: proc { |target| 
        "#{target.heal(40)}. #{target.add_status(:regenerating, {turns: 2, heal: 15})}" 
      }
    )
  end
  
  def self.amethyst
    CrystalGem.new(
      name: "Amethyst",
      description: "Protect a target from 1 instance of damage",
      action: proc { |target| 
        target.add_status(:protected, {turns: 1})
      }
    )
  end

  def self.opal
    CrystalGem.new(
      name: "Opal",
      description: "Protect a target from 3 instances of damage",
      action: proc { |target| 
        target.add_status(:protected, {turns: 3})
      }
    )
  end

  def self.obsidian
    CrystalGem.new(
      name: "Obsidian",
      description: "Aply cursed status to a single enemy",
      action: proc { |target|
        target.add_status(:cursed, {turns: 1})
      }
    )
  end
  
  def self.heliodor
    CrystalGem.new(
      name: "Heliodor",
      description: "Apply hasted status to a single target for 2 turns",
      action: proc { |target| 
        target.add_status(:hasted, {turns: 2})
      }
    )
  end

  def self.yellow_diamond
    CrystalGem.new(
      name: "Yellow Diamond",
      description: "Heal and apply hasted status to a single target for 3 turns",
      action: proc { |target| 
        "#{target.heal(40)}. #{target.add_status(:hasted, {turns: 3})}"
      }
    )
  end

  def self.pink_diamond
    CrystalGem.new(
      name: "Pink Diamond",
      description: "Heal a lot of hp and apply regenerating status to a single target",
      action: proc { |target| 
        "#{target.heal(100)}. #{target.add_status(:regenerating, {turns: 3, heal: 20})}" 
      }
    )
  end

  def self.diamond
    CrystalGem.new(
      name: "Oneshot aoe",
      target: :aoe,
      description: "Deals heavy damage to everyone",
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += " > #{t.damage(100)}.\n"
        }
      }
    )
  end

  def self.black_diamond
    CrystalGem.new(
      name: "Black Diamond",
      target: :single,
      description: "Kill a single target",
      action: proc { |target|
        target.damage(1000)
      }
    )
  end
end