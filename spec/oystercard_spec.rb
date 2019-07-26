require_relative '../app/oystercard'

describe Oystercard do

  subject {described_class.new}

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end


  describe '#top_up' do
    let(:station){ double :station }

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should update balance by amount specified' do
      expect(subject.balance).to eq(0)

      subject.top_up(1)

      expect(subject.balance).to eq(1)
    end

    it 'will add the amount if it doesnt exceed the upper limit' do
      maximum_balance = 89
      subject.top_up(maximum_balance)
      expect(subject.top_up 1).to eq 90
    end

    it 'will not add the amount if it will exceed the upper limit' do
      maximum_balance = 90
      subject.top_up(maximum_balance)
      expect(subject.top_up 1).to eq 90
    end

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'is initially not in a journey' do
      expect(subject.in_journey).to eq(false)
    end

    it 'is initially not in a journey' do
      subject.journey

      expect(subject.in_journey).to eq(true)
    end

    it 'will not touch in if below minimum balance' do
      expect(subject.in_journey).to eq(false)
    end

    it 'decuct from balance if enough' do
      subject.top_up(10)
      station = 'station name'
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-1)
    end

    let(:station){ double :station }

    it 'stores the entry station' do
      station = 'station name'
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it 'should be nil when we touch out' do
      station = 'station name'
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq(nil)
    end

  end

end

