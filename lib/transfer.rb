class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? && @status == "pending" && (@sender.balance && @receiver.balance >= @amount)
  end

  def execute_transaction
    if valid?
      @sender.deposit(-@amount)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.deposit(-@amount)
      @status = "reversed"
    else
      "Only completed transactions can be reversed."
    end
  end


end
