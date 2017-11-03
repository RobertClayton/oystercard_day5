require './lib/journey.rb'
require './lib/oystercard.rb'

describe Journey do
  subject(:journey) { described_class.new }
  let(:card) { Oystercard.new(journey) }
  let(:station) { double(:station) }

  def top_up_touch_in
    card.top_up(50)
    card.touch_in(station)
  end

  def in_and_out
    card.top_up(50)
    card.touch_in(station)
    card.touch_out(station)
  end

  it 'knows if the journey is not complete' do
    top_up_touch_in
    expect(journey.journey_complete?).to eq(false)
  end

  it 'has a penalty fare by default' do

  end

  it "returns itself when exiting a journey" do

  end

  context 'given an entry station' do
    it 'has an entry station' do
      top_up_touch_in
      expect(journey.entry_station).to eq station
    end

    it 'returns a penalty fare if no exit given' do

    end

    context 'given an entry_station' do

      it 'caculates a fare' do

      end

      it 'knows if a journey is in-complete' do
        in_and_out
        expect(journey.journey_complete?).to eq (true)
      end
    end


  end

  # describe 'initialize' do
  #   it 'should create an empty hash for current_journey' do
  #     expect(subject.current_journey).to eq Hash.new
  #   end
  # end
  #
  # describe '#in_journey?' do
  #   it 'should return either true or false' do
  #     expect(subject.in_journey?).to eq(true).or eq(false)
  #   end
  #
  #   it 'should change card.injourney? to false when entry equals nil' do
  #     in_and_out
  #     expect(card.in_journey?).to eq(false)
  #   end
  #
  #   it 'should change card.injourney? to true when entry is not nil' do
  #     top_up_and_in
  #     expect(card.in_journey?).to eq(true)
  #   end
  # end
  #
  # describe '#set_entry' do
  #   it 'should store the entry station' do
  #     top_up_and_in
  #     expect(journey.entry).to eq(station)
  #   end
  # end
  #
  #
  # describe '#clear_current_journey' do
  #   it 'should set entry to nil' do
  #     in_and_out
  #     expect(journey.entry).to eq nil
  #   end
  # end
  #
  # describe '#current_journey' do
  #   it 'should store a hash of the current journey' do
  #     card.top_up(50)
  #     card.touch_in('A')
  #     card.touch_out('B')
  #     card.touch_in('C')
  #     card.touch_out('D')
  #     expected_hash = [{ 'A' => 'B' }, { 'C' => 'D' }]
  #     expect(card.list_of_journeys).to eq(expected_hash)
  #     #expect(card.list_of_journeys).to eq[{ station => station }]
  #   end
  # end
end
