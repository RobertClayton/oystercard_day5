class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY = 6
  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  def set_entry(entry_station)
    @entry_station = entry_station
  end

  def set_exit(exit_station)
    @exit_station = exit_station
  end

  def penalty?

  end
  def fare
    a = (entry_station = nil) && (exit_station = !nil)
    b = (entry_station = !nil) && (exit_station = nil)
    if a || b
      return PENALTY
    else
      return MINIMUM_FARE
    end
  end

end
