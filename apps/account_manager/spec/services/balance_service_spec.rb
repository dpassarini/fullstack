require 'rails_helper'

RSpec.describe BalanceService do
  context 'Calculated balance' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, name: Faker::Company.name, users: [user1]) }
    let!(:child_account1)  { FactoryBot.create(:account, name: Faker::Company.name, users: [user1], parent_account_id: parent_account.id) }

    it 'should return a balance from an account' do
      ts = TransferService.new
      identifier1 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 20_000)
      identifier1 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 40_000)

      result = ts.transfer_value(receiver_account_id: child_account1.id, sender_account_id: parent_account.id, value_cents:10_000)

      expect(BalanceService.total_balance(parent_account.id).to_i).to eq(50_000)
      expect($redis.get("balance:#{parent_account.id}").to_i).to eq(50_000)
    end
  end
end
