class Oystercard

MAXIMUM_BALANCE = 90

  attr_reader :balance
  attr_reader :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
  fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
   @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_use = true
    return "You've touched in"
  end

  def touch_out
    @in_use = false
    return "You've touched out"
  end

  def in_journey?
    @in_use
  end

  def check_balance
    @balance
  end

end
