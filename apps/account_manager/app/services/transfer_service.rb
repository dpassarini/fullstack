class TransferService
  def charge_account(receiver_account_id:, value_cents:)
    account = Account.find(receiver_account_id)
    if account.can_be_charged?
      identifier = SecureRandom.uuid
      Transfer.create(
        receiver_account_id: receiver_account_id,
        value_cents: value_cents,
        description: 'Charge',
        charge_identifier: identifier
      )
      return identifier
    end
    false
  end

  def transfer_value(receiver_account_id:, sender_account_id:, value_cents:)
    receiver = Account.find(receiver_account_id)
    sender = Account.find(sender_account_id)

    return { transfer: false, message: 'both accounts must active' } unless receiver.active? && sender.active?

    if receiver.can_receive_from_this_account?(sender)
      identifier = SecureRandom.uuid

      # credit to the receiver
      Transfer.create(
        receiver_account_id: receiver_account_id,
        sender_account_id: sender_account_id,
        value_cents: value_cents.to_i,
        description: "Credit from account: #{sender.name}",
        charge_identifier: identifier
      )

      # debt to the sender
      Transfer.create(
        receiver_account_id: sender_account_id,
        sender_account_id: receiver_account_id,
        value_cents: value_cents.to_i * -1,
        description: "Value sent to: #{receiver.name}",
        charge_identifier: identifier
      )
      BalanceService.total_balance(receiver_account_id)
      BalanceService.total_balance(sender_account_id)
      { transfer: true, message: identifier }
    else
      { transfer: false, message: 'cannot make transfers between these accounts' }
    end
  end

  def cash_back(identifier)
    transfers = Transfer.where(charge_identifier: identifier)
    return false unless transfers.present?
    transfers.each do |trans|
      new_identifier = SecureRandom.uuid
      Transfer.create(
        receiver_account_id: trans.receiver_account_id,
        value_cents: trans.value_cents * -1,
        description: "Cash back originated from #{trans.charge_identifier}",
        charge_identifier: new_identifier
      )
      BalanceService.total_balance(trans.receiver_account_id)
    end
    return identifier
  end
end
