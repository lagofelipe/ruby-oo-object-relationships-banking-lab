
class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount

    @status = 'pending'
  end

  def valid?
    (self.sender.valid?)&&(self.receiver.valid?)
  end

  def is_everything_true?
    self.valid? && @status == "pending" && self.sender.balance > @amount
  end

  def make_changes
    self.sender.balance -= @amount
    self.receiver.balance += @amount 
  end

  def execute_transaction
    if is_everything_true?
      make_changes
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def undo_changes
    self.sender.balance += @amount
    self.receiver.balance -= @amount 
    @status = "reversed"
  end

  def reverse_transfer
    undo_changes if @status == "complete" 
  end

end
