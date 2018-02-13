require 'rails_helper'

RSpec.describe TransferService do
  context 'Charging accounts' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }
    let!(:child_account1)  { FactoryBot.create(:account, users: [user1], parent_account_id: parent_account.id) }

    it 'account should receive values' do
      ts = TransferService.new
      result = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 20_000)

      expect(result).to be_truthy
      expect(parent_account.received_values.count).to eq(1)
      expect(parent_account.sent_values.count).to eq(0)
    end

    it 'account should not be charged' do
      ts = TransferService.new
      result = ts.charge_account(receiver_account_id: child_account1.id, value_cents: 20_000)

      expect(result).to be_falsey
    end
  end

  context 'Transfer between accounts' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }
    let!(:child_account1)  { FactoryBot.create(:account, users: [user1], parent_account_id: parent_account.id) }

    it 'account should receive values' do
      ts = TransferService.new
      ts.transfer_value(
        receiver_account_id: child_account1.id,
        sender_account_id: parent_account.id,
        value_cents: 20_000
      )

      expect(parent_account.received_values.count).to eq(1)
      expect($redis.get("balance:#{parent_account.id}").to_i).to eq(-20_000)
    end

    it 'should not allow a transfer involving at least on non-active account' do
      child_account1.update_attributes(status: 'blocked')

      ts = TransferService.new
      result = ts.transfer_value(
        receiver_account_id: child_account1.id,
        sender_account_id: parent_account.id,
        value_cents: 20_000
      )

      expect(result[:transfer]).to be_falsey
    end
  end

  context 'Cash back' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }

    it 'should give money back' do
      ts = TransferService.new
      result1 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 20_000)
      result2 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 30_000)
      ts.cash_back(result1)

      expect($redis.get("balance:#{parent_account.id}").to_i).to eq(30_000)
    end
  end
end
