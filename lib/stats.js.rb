module Stats
  
  def max_hp()
    10 + self.consitution() * 2 + self.level() * 2 
  end

  def level()
    1
  end

  def consitution()
    cached[:constitution]
  end
end