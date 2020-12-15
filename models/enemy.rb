require_relative "./gem"
require_relative "./character"

class Enemy < Character
  attr_reader :type, :attack_power, :attack_skill, :defense_skill
  def initialize(
    name: "Enemy",
    attack_gem: nil,
    defense_gem: nil,
    attack_power: 10
  )
    super(name: name)
    @attack_skill  = attack_gem ? {name: attack_gem.name, action: attack_gem.action, cd: 0} : attack_gem
    @defense_skill = defense_gem ? {name: defense_gem.name, action: defense_gem.action, cd: 0} : defense_gem
    @attack_power  = attack_power
  end

  def attack target
    outcome = target.damage @attack_power
    return "#{@name} attacks #{outcome}"
  end

  def use_attack_skill target
    outcome = @attack_skill[:action].call(target)
    @attack_skill[:cd] = 3
    "#{@name} uses the power of #{@attack_skill[:name]}. #{outcome}"
  end

  def use_defense_skill target
    outcome = @defense_skill[:action].call(target)
    @defense_skill[:cd] = 3
    "#{@name} uses the power of #{@defense_skill[:name]}. #{outcome}"
  end

  def below_half_hp?
    @hp / @total_hp.to_f < 0.5
  end

  def reduce_cooldowns
    @attack_skill[:cd] -= 1 if @attack_skill && @attack_skill[:cd] > 0
    @defense_skill[:cd] -= 1 if @defense_skill && @defense_skill[:cd] > 0
  end
end
