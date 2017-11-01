require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:topped_up_card) { described_class.new }
  let(:station) { double(:station) }

  before do
    topped_up_card.top_up(5)
  end

  describe 'initialize' do
    it 'Check if oystercard has a balance equal to 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'Check if @balance increase after top_up' do
      expect(topped_up_card.balance).to eq(5)
    end

    it 'top_up raise error when above the limit' do
      subject.top_up(Oystercard::LIMIT)
      sum = Oystercard::LIMIT - subject.balance
      error_top_up = "This exceeds the card limit. You can top_up only #{sum}"
      expect { subject.top_up(1) }.to raise_error(error_top_up)
    end
  end

  describe '#touch_in' do
    it 'should change in journey to true' do
      topped_up_card.touch_in(:station)
      expect(topped_up_card.in_journey?).to eq true
    end

    it 'raises error if balance is less than minimum' do
      message = 'Insufficient balance for travel'
      expect { subject.touch_in(:station) }.to raise_error(message)
    end

    it 'remembers the enrty station' do
      topped_up_card.touch_in('Aldgate East')
      expect(topped_up_card.entry_station).to eq 'Aldgate East'
    end
  end

  describe '#touch_out' do
    def in_out
      topped_up_card.touch_in(:station)
      topped_up_card.touch_out
    end

    it 'should change in journey to false' do
      in_out
      expect(topped_up_card.in_journey?).to eq false
    end

    it 'check if touch_out reduce balance by minumum fare' do
      in_out
      expect(topped_up_card.balance).to eq(4)
    end

    it 'should set entry station to nil' do
      in_out
      expect(topped_up_card.entry_station).to eq nil
    end
  end

  describe '#in_journey?' do
    it 'Check if the card is in use or not.' do
      topped_up_card.touch_in(:station)
      expect(topped_up_card.in_journey?).to eq(true)
    end
  end
end
