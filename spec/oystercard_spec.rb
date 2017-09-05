require 'oystercard'
require 'station'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
  end

    it 'raises an error if the maximum balance is exceeded' do
     maximum_balance = Oystercard::MAXIMUM_BALANCE
     subject.top_up(maximum_balance)
     expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

    describe "insufficient funds" do
      let(:station){ double :station }
      it 'raises an error if card has insufficient funds' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect{ subject.touch_in(station) }.to raise_error "Insufficient funds. Please top up!"
      end
    end

  describe '#deduct' do
    it "is able to deduct from balance" do
      amount = ((Oystercard::MINIMUM_BALANCE) - (subject.balance))
      # subject.top_up(amount)
    # expect(subject).to respond_to(:deduct, amount)
    expect{ subject.send(:deduct, amount)}.to change{ subject.balance }.by(-amount)
    end
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  describe "#touch_in" do
    let(:station){ double :station }
    it "can be touched in" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
  end

  it "can be touched out" do
    subject.top_up(5)
    # subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end

  describe "#check_balance" do
    it { is_expected.to respond_to(:check_balance) }
  end

  describe "entry_station" do
    let(:station){ double :station }
    it "stores the entry station of current journey after touch in" do
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
    end
  end

end
