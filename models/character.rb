class Character
  attr_reader :name, :hp, :status, :total_hp

  def initialize(name: "Default Name")
    @name     = name
    @hp       = 100
    @total_hp = @hp
    @status   = {}
  end

  def heal(amount)
    if @status[:cursed]
      @hp -= amount
      @status[:cursed][:turns] -= 1
      return "#{@name} and #{amount} of damage because the target is cursed"
      status_over()
    end
      @hp += amount
      @hp = 100 if @hp > 100
      return "#{@name} and heals #{amount} hp"
  end

  def damage(amount)
    if @status[:protected]
      amount = 0
      @status[:protected][:turns] -= 1
      status_over()
      return "#{@name} and deals 0 damage becase the target is protected"
    end
    @hp -= amount
    @hp = 0 if @hp < 0
    return "#{@name} and deals #{amount} damage"
  end

  def add_status(status_key, status_value)
    @status[status_key] = status_value
    return "#{@name} is now affected by #{status_key} status"
  end

  def status_over
    @status.delete_if { |k, v| v[:turns] == 0 }
  end

  def apply_status_effects
    outcome = ""
    return if @status.empty?
    @status.each do |k, v|
      case k
      when :burning
        outcome += "Burning status affects #{damage(v[:damage])} " 
      when :regenerating
        outcome += "Regenerating status affects #{heal(v[:heal])}" 
      end
      v[:turns] -= 1
    end
    status_over
    outcome
  end

  def is_frozen?
    if @status[:frozen]
      @status[:frozen][:turns] -= 1
      status_over()
      return true
    end
    false
  end

end
