require 'journey'

# This is a simulation of an Oystercard system
class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :list_of_journeys, :j_class # :journey,

  def initialize(j_class = Journey.new, balance = 0)
    @balance = balance
    @list_of_journeys = []
    #@journey = {}
    @j_class = j_class
  end

  def top_up(amount)
    raise error_top_up if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient balance for travel' if @balance < MINIMUM_FARE
    # 1 - complete
    #@entry_station = entry_station
    @j_class.set_entry(entry_station)
    # 2 - complete
    #@journey[entry_station]
    @j_class.current_journey[entry_station]
  end

  def touch_out(exit_station)
    # 3 - complete
    deduct if in_journey?
    # 4 - complete
    #@journey[@entry_station] = exit_station
    @j_class.current_journey[@j_class.entry] = exit_station
    # 5 - complete
    add_journey
    #@j_class.add_journey
    # 6 - complete
    #@entry_station = nil
    @j_class.set_entry(nil)
  end

  def in_journey?
    # 7 - complete
    #@entry_station != nil
    @j_class.in_journey?
  end

  def error_top_up
    "This exceeds the card limit. You can top_up only #{LIMIT - @balance}"
  end

  private

  def add_journey
    # 8 - !!!!!!!!
    #@list_of_journeys << @journey
    @list_of_journeys << @j_class.current_journey
    # 9 - !!!!!!!!
    #@journey = {}
    @j_class.clear_current_journey
  end

  def deduct
    @balance -= MINIMUM_FARE
  end
end
