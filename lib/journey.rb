class Journey
  attr_reader :current_journey, :entry

  def initialize
    @current_journey = {}
  end

  def in_journey?
    @entry != nil
  end

  def set_entry(entry_station)
    @entry = entry_station
  end

  def clear_current_journey
    @current_journey = {}
  end
end
