require './lib/journey.rb'

# This is a simulation of an Oystercard system
class Oystercard
  LIMIT = 90

  attr_reader :balance, :entry_station, :list_of_journeys, :trip

  def initialize(trip = Journey.new, balance = 0)
    @balance = balance
    @list_of_journeys = []
    @trip = trip
  end

  def top_up(amount)
    raise error_top_up if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    if in_journey?
      deduct(@trip.fare)
      add_journey
      new_journey
    end
    raise 'Insufficient balance for travel' if @balance < Journey::MINIMUM_FARE
    @trip.store_entry(entry_station)
  end

  def touch_out(exit_station)
    if @trip.there_an_entry?
      deduct(@trip.fare)
    else
      @trip.store_exit(exit_station)
      deduct(@trip.fare(Journey::MINIMUM_FARE))
    end
    add_journey
    new_journey
  end

  def in_journey?
    @trip.in_journey?
  end

  def error_top_up
    "This exceeds the card limit. You can top_up only #{LIMIT - @balance}"
  end

  private

  def add_journey
    @list_of_journeys << @trip
  end

  def deduct(amount)
    @balance -= amount
  end

  def new_journey
    @trip = Journey.new
  end
end
