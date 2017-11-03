require './lib/journey.rb'
require './lib/journeylog.rb'

# This is a simulation of an Oystercard system
class Oystercard
  LIMIT = 90

  attr_reader :balance, :journey_log

  def initialize(journey_log = JourneyLog.new, balance = 0)
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(amount)
    raise error_top_up if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    touch_in_penalty
    raise 'Insufficient balance for travel' if @balance < Journey::MINIMUM_FARE
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.touch_out_penalty(exit_station)
    charge_fare(exit_station) if @journey_log.there_a_penalty == false
    touch_out_penalty(exit_station) if @journey_log.there_a_penalty
  end

  def error_top_up
    "This exceeds the card limit. You can top_up only #{LIMIT - @balance}"
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def touch_in_penalty
    @journey_log.touch_in_penalty
    deduct(@journey_log.fare) if @journey_log.there_a_penalty
    @journey_log.reset_penalty
  end

  def touch_out_penalty(exit_station)
    deduct(@journey_log.fare)
    @journey_log.finish(exit_station)
    @journey_log.reset_penalty
  end

  def charge_fare(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.fare(Journey::MINIMUM_FARE))
  end
end
