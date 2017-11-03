# this is one journey for use with Oystercard
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

  def there_no_entry_station?
    @entry_station.nil?
  end

  def store_entry(entry_station)
    @entry_station = entry_station
  end

  def store_exit(exit_station)
    @exit_station = exit_station
  end

  def fare(amount = PENALTY)
    amount
  end
end
