require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'Multiple accounts' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }
    let!(:child_account1)  { FactoryBot.create(:account, users: [user1], parent_account_id: parent_account.id) }
    let!(:child_account2)  { FactoryBot.create(:account, users: [user2], parent_account_id: parent_account.id) }
    let!(:other_account)  { FactoryBot.create(:account, users: [user2]) }

    it 'parent_account should have two sub_accounts' do
      expect(parent_account.sub_accounts.count).to eq(2)
    end

    it 'user1 should have two accounts' do
      expect(user1.accounts.count).to eq(2)
    end

    it 'verifies if account is master account' do
      expect(parent_account.is_master?).to be_truthy
      expect(child_account1.is_master?).to be_falsey
    end

    it 'verifies if can receive from an account' do
      expect(child_account1.can_receive_from_this_account?(parent_account)).to be_truthy
      expect(parent_account.can_receive_from_this_account?(other_account)).to be_falsey
    end
  end

  context 'Checking status' do
    let!(:user1) { FactoryBot.create(:user, email: Faker::Internet.email) }
    it 'should not validate an unkown status' do
      invalid_account = FactoryBot.build(:account, users: [user1], status: 'aceito')
      expect(invalid_account.valid?).to be_falsey
    end
  end
end
