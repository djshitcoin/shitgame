module Entity
  
  def max_hp()
    10 + self.consitution() * 2 + self.level() * 2 
  end

  def level()
    1
  end

  def hp_percentage()
    100 * hp() / max_hp()
  end

  def start_regenerating_at()
    if self.cached['hp'] <= 0
      self.cached['hp_updated_at'] + self.down_time()
    else
      self.cached['last_combat_at'] + self.regen_wait_time()
    end
  end

  def down_time()
    15
  end

  def regen_wait_time()
    3
  end

  def hp()
    return [self.cached['hp'], 0].max() if self.start_regenerating_at() > Time.now
    [[self.cached['hp'], 0].max() + (Time.now - self.start_regenerating_at()) * self.regeneration_rate(), self.max_hp()].min()
  end

  def regeneration_rate()
    3
  end
  
  def remaining_downtime()
    [self.start_regenerating_at() - Time.now, 0].max()
  end

  def consitution()
    self.cached['constitution']
  end
end