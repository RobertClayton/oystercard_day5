require './lib/journey.rb'
require './lib/oystercard.rb'

describe Journey do
  subject(:journey) { described_class.new }
  let(:card) { Oystercard.new(journey) }
  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  def top_up_touch_in
    card.top_up(50)
    card.touch_in(station)
  end

  def in_and_out
    card.top_up(50)
    card.touch_in(station)
    card.touch_out(station)
  end

  describe '#in_journey?' do
    it 'knows if the journey is not complete' do
      top_up_touch_in
      expect(journey.in_journey?).to eq(true)
    end
  end

  describe '#fare' do
    it 'has a penalty fare by default' do
      expect(journey.fare).to eq Journey::PENALTY
    end

    it 'returns a penalty fare if no exit given' do
      top_up_touch_in
      card.touch_in(station)
      expect(card.balance).to eq 50 - Journey::PENALTY
    end

    it 'returns a penalty fare if no entry given' do
      card.top_up(50)
      card.touch_out(station)
      expect(card.balance).to eq 50 - Journey::PENALTY
    end

    it 'caculates a fare' do
      in_and_out
      expect(card.balance).to eq 50 - Journey::MINIMUM_FARE
    end
  end

  describe '#entry_station' do
    it 'has an entry station' do
      top_up_touch_in
      expect(journey.entry_station).to eq station
    end
  end

  describe '#exit_station' do
    it 'has an exit station' do
      in_and_out
      expect(journey.exit_station).to eq station
    end
  end

  describe 'outputs' do
    it 'returns itself when exiting a journey' do
      in_and_out
      expect(card.list_of_journeys[0]).to eq journey
    end

    it 'should save entry_station to nil when just a touch_out' do
      card.top_up(50)
      card.touch_out(station)
      expect(card.list_of_journeys[0].entry_station).to eq nil
    end
  end
end
