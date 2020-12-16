require_relative "../models/gem"

module GemAssets
  def self.ruby 
    CrystalGem.new(
      name: "Ruby",
      description:"Deal damage and apply burning status to a single target",
      action: proc { |target|
        "#{target.damage(20)}. #{target.add_status(:burning, {turns: 2, damage: 5})}"
      }
    )
  end
  
  def self.sapphire
    CrystalGem.new(
      name: "Sapphire",
      description: "Deal damage and apply frozen status to a single target",
      action: proc { |target| 
        "#{target.damage(10)}. #{target.add_status(:frozen, {turns: 1})}"
      }
    )
  end
  
  def self.emerald
    CrystalGem.new(
      name: "Emerald",
      description: "Heal and apply regenerating status to a single target",
      action: proc { |target| 
        "#{target.heal(25)}. #{target.add_status(:regenerating, {turns: 2, heal: 10})}" 
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
  def self.lapis_lazuli
    CrystalGem.new(
      name: "Lapis Lazuli",
      target: :aoe,
      description: "Deals damage and applies frozen status to all enemies",
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += " > #{t.damage(10)}. #{t.add_status(:frozen, {turns: 2})}\n"
        }
      }
    )
  end
  
  def self.test_op
    CrystalGem.new(
      name: "Oneshot",
      target: :aoe,
      description: "Test gem that kills everyone",
      action: proc { |targets|
        targets.reduce("") { |o, t|
          o += " > #{t.damage(100)}.\n"
        }
      }
    )
  end
end