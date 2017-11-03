require './lib/station.rb'

describe Station do
  subject(:station) { described_class.new('abc', 1) }

  describe 'initialize' do
    it 'should return station\'s name' do
      expect(subject.name).to eq 'abc'
    end

    it 'should return station\'s zone' do
      expect(subject.zone).to eq 1
    end
  end
end
