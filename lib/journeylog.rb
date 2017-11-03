class JourneyLog
  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
    @list_of_journeys = []
  end


  def start # Should start a new journey with an etry station
  end

  def finish # Should add an exit station to current journey
  end

  def journeys # Should return the list of journey_class
  end

  private

  attr_reader :list_of_journeys

  def current_journey # Should return complete or incomplete journey
  end
end
# Comments
