module EntityProto
  def required_exp()
    return @cached_table if @cached_table
    @cached_table = [
      0,
      20,
      50,
      85,
      130,
      180,
      250
    ]
  end

  def max_hp()
    10 + self.consitution() * 2 + self.level() * 2 
  end

  def level()
    level = 0
    level += 1 while self.stats['exp'] >= self.required_exp()[level]
    return level
  end

  def level_up_percentage()
    100 * self.exp_on_level() / (self.exp_on_level() + self.exp_remaining())
  end

  def exp_remaining()
    self.level_up_at() - self.stats['exp']
  end

  def exp_on_level()
    self.stats['exp'] - self.required_exp()[self.level()-1]
  end

  def level_up_at()
    self.required_exp()[self.level()]
  end

  def level_up_at_relative()
    level = self.level()
    self.required_exp()[level] - self.required_exp()[level-1]
  end

  def hp_percentage()
    100 * self.hp() / self.max_hp()
  end

  def start_regenerating_at()
    if self.last_hp <= 0
      self.last_hp_updated_at + self.down_time()
    else
      self.last_combat_at + self.regen_wait_time()
    end
  end

  def down_time()
    15
  end

  def regen_wait_time()
    3
  end

  def alive()
    hp() > 0
  end

  def hp()
    return [self.last_hp, 0].max() if self.start_regenerating_at() > Time.unix
    [[self.last_hp, 0].max() + (Time.unix - self.start_regenerating_at()) * self.regeneration_rate(), self.max_hp()].min()
  end

  def regeneration_rate()
    3
  end
  
  def remaining_downtime()
    [self.start_regenerating_at() - Time.unix, 0].max()
  end

  def consitution()
    self.stats['constitution']
  end
end