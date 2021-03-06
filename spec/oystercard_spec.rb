require 'oystercard'
require 'station'

describe Oystercard do
  let(:station){double :station}
  # let(:exit_station) {double :station}


  it "has an empty list of journeys by default" do
    expect(subject.journey_history).to be_empty
  end


  it 'stores journey history' do
    subject.top_up(5)
    # allow(subject).to receive(:journey_history).and_return(1)
    expect{subject.touch_in(station)}.to change{subject.journey_history.count}.by(1)
  end


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
    expect(subject.in_journey).to eq false
  end

  describe "#touch_in" do
    let(:station){ double :station }
    it "can be touched in" do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.in_journey).to eq true
    end
  end

  it "can be touched out" do
    subject.top_up(5)
    # subject.touch_in
    subject.touch_out(station)
    expect(subject.in_journey).to eq false
  end

  describe "#check_balance" do
    it { is_expected.to respond_to(:check_balance) }
  end

  describe "#entry_station" do
    let(:station){ double :station }
    it "stores the entry station of current journey after touch in" do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.entry_station(station)).to eq(station)
    end
  end

  describe "#exit_station" do
    it "stores exit station" do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station(station)).to eq(station)
    end
  end

end
