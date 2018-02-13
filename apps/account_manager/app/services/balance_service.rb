class BalanceService
  def self.total_balance(account_id)
    balance_value = $redis.get("balance:#{account_id}")
    if balance_value.nil?
      value = Transfer.where(receiver_account_id: account_id).sum(:value_cents)
      $redis.set("balance:#{account_id}", value)
      value
    else
      balance_value
    end
  end
end
