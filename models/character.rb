class Character
  attr_reader :name, :hp, :status, :total_hp

  def initialize(name: "Default Name", total_hp: 100)
    @name     = name
    @hp       = total_hp
    @total_hp = total_hp
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
      return "#{@name} heals #{amount} hp"
  end

  def damage(amount)
    if @status[:protected]
      amount = 0
      @status[:protected][:turns] -= 1
      status_over()
      return "#{@name} takes 0 damage becase of protected status"
    end
    @hp -= amount
    @hp = 0 if @hp < 0
    return "#{@name} takes #{amount} damage"
  end

  def add_status(status_key, status_value)
    @status[status_key] = status_value
    return "#{status_key.capitalize} status has been applied"
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
        outcome += "Burning status effect: #{damage(v[:damage])}. "
        v[:turns] -= 1 
      when :regenerating
        outcome += "Regenerating status effect: #{heal(v[:heal])}. "
        v[:turns] -= 1
      end
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
  
  def is_hasted?
    if @status[:hasted]
      @status[:hasted][:turns] -= 1
      status_over()
      return true
    end
    false
  end

  def is_dead?
    @hp == 0
  end
end
