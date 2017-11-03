require './lib/journey.rb'

# this is responcible for starting, ending and storing journeys
class JourneyLog
  attr_reader :there_a_penalty

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @list_of_journeys = []
    @there_a_penalty = false
  end

  # Should start a new journey with an entry station
  def start(entry_station)
    @journey_class.store_entry(entry_station)
  end

  # Should add an exit station to current journey
  def finish(exit_station)
    @journey_class.store_exit(exit_station)
    add_and_new_journey
  end

  # Should return the list of journey_class
  def journeys
    @list_of_journeys
  end

  def in_journey?
    @journey_class.in_journey?
  end

  def there_no_entry_station?
    @journey_class.there_no_entry_station?
  end

  def touch_in_penalty
    if in_journey?
      @there_a_penalty = true
      add_and_new_journey
    end
  end

  def touch_out_penalty(exit_station)
    if there_no_entry_station?
      @there_a_penalty = true
    end
  end

  def fare(amount = Journey::PENALTY)
    @journey_class.fare(amount)
  end

  def reset_penalty
    @there_a_penalty = false
  end

  private

  attr_reader :list_of_journeys

  # Should return complete or incomplete journey
  # def current_journey
  #   @journey_class
  # end

  def add_and_new_journey
    add_journey
    new_journey
  end

  def add_journey
    @list_of_journeys << @journey_class
  end

  def new_journey
    @journey_class = Journey.new
  end
end
