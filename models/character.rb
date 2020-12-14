class Character
  attr_reader :name, :hp, :status

  def initialize(name: "Default Name")
    @name   = name
    @hp     = 100
    @status = {}
  end

  def heal(amount)
    if @status[:cursed]
      amount = -amount
      @status[:cursed][:turns] -= 1
      status_over()
    end
      @hp += amount
      @hp = 100 if @hp > 100
  end

  def damage(amount)
    if @status[:protected]
      amount = 0
      @status[:protected][:turns] -= 1
      status_over()
    end
    @hp -= amount
    @hp = 0 if @hp < 0
  end

  def add_status(status_key, status_value)
    @status[status_key] = status_value
  end

  def status_over
    @status.delete_if { |k,v| v[:turns] == 0 }
  end

  def apply_status_effects
    return if @status.empty?
    @status.each do |k, v|
      case k
      when :burning
        damage(v[:damage])
      when :regenerating
        heal(v[:heal])
      end
      v[:turns] -= 1
    end
    status_over
  end

end
