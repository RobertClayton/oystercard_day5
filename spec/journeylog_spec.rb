require './lib/journey.rb'
require './lib/oystercard.rb'
require './lib/station.rb'

describe JourneyLog do
  let(:journey) { Journey.new }
  subject(:journey_log) { described_class.new(journey) }
  let(:card) { Oystercard.new(journey_log) }
  let(:station) { double(:station) }

  BALANCE = 50

  def top_up_and_touch_in
    card.top_up(BALANCE)
    card.touch_in(station)
  end

  def touch_in_and_touch_out
    card.top_up(BALANCE)
    card.touch_in(station)
    card.touch_out(station)
  end

  describe '#there_a_penalty' do
    it 'should return either true or false' do
      expect(journey_log.there_a_penalty).to eq(true).or eq(false)
    end
  end

  describe '#start' do
    it 'should set an entry_station' do
      touch_in_and_touch_out
      expect(card.journey_log.journeys[0].entry_station).to eq station
    end
  end

  describe '#finish' do
    it 'should set an exit_station' do
      touch_in_and_touch_out
      expect(card.journey_log.journeys[0].exit_station).to eq station
    end
  end

  describe '#journeys' do
    it 'should return a list of journeys' do
      touch_in_and_touch_out
      expect(card.journey_log.journeys).to eq [journey]
    end
  end

  describe '#in_journey?' do
    it 'should return either true or false' do
      expect(journey_log.in_journey?).to eq(true).or eq(false)
    end
  end

  describe '#there_no_entry_station?' do
    it 'should return true if there is not entry_station' do
      top_up_and_touch_in
      expect(card.journey_log.there_no_entry_station?).to eq false
    end
  end

  describe '#fare' do
    it 'should charge minumum fare' do
      touch_in_and_touch_out
      expect(card.balance).to eq BALANCE - Journey::MINIMUM_FARE
    end

    it 'should charge a penalty if double touch_in' do
      top_up_and_touch_in
      card.touch_in(station)
      expect(card.balance).to eq BALANCE - Journey::PENALTY
    end

    it 'should charge a penalty if touch_out and no touch_in' do
      card.top_up(BALANCE)
      card.touch_out(station)
      expect(card.balance).to eq BALANCE - Journey::PENALTY
    end
  end

  describe '#reset_penalty' do
    it 'should charge the minumum fare after a penalty' do
      card.top_up(BALANCE)
      card.touch_out(station)
      card.touch_in(station)
      card.touch_out(station)
      sum = BALANCE - Journey::PENALTY - Journey::MINIMUM_FARE
      expect(card.balance).to eq sum
    end
  end
end
