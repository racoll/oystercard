class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 2

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :entry_and_exit


  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @journey_history = nil
    entry_and_exit = Hash.new
  end

  def top_up(amount)
  raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
   @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds. Please top up!" if balance < MINIMUM_BALANCE
    @in_journey = true
    return "You've touched in"
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @in_journey = false
    return "You've touched out"
    @entry_station = nil
  end

  # def in_journey?
  #   @in_journey = true
  #   !!entry_station
  # end

  def check_balance
    @balance
    # fail "Insufficient funds. Please top up!" if @balance < 1
  end

  def deduct(amount)
    @balance -= amount
  end

  def entry_station(station)
    @entry_station = station
  end



private :deduct

end
