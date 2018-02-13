require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
  let!(:parent_account)  { FactoryBot.create(:account, name: Faker::Company.name, users: [user1]) }
  let!(:child_account1)  { FactoryBot.create(:account, name: Faker::Company.name, users: [user1], parent_account_id: parent_account.id) }
  let!(:token) { double acceptable?: true }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe 'POST charge_account' do
    it 'should charge some value to parent account' do
      body = {
        transfer: {
          receiver_account_id: parent_account.id,
          value_cents: 20_000
        }
      }

      post :charge_account, params: body

      expect(response.status).to eq(201)
      expect(BalanceService.total_balance(parent_account.id).to_i).to eq(20_000)
    end
  end

  describe 'POST transfer' do
    it 'should transfer value to account' do
      body = {
        transfer: {
          receiver_account_id: child_account1.id,
          sender_account_id: parent_account.id,
          value_cents: 5000
        }
      }

      post :transfer, params: body

      # updated balance
      expect(BalanceService.total_balance(parent_account.id).to_i).to eq(-5000)
      expect(BalanceService.total_balance(child_account1.id).to_i).to eq(5000)
    end
  end

  describe 'POST cash_back' do
    it 'should post a cash back' do
      ts = TransferService.new
      result1 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 20_000)
      result2 = ts.charge_account(receiver_account_id: parent_account.id, value_cents: 30_000)

      body = {
        transfer: {
          charge_identifier: result1
        }
      }

      post :cash_back, params: body

      expect(response.status).to eq(201)
      expect($redis.get("balance:#{parent_account.id}").to_i).to eq(30_000)
    end

    it 'should not find a transfer to cash back' do
      body = {
        transfer: {
          charge_identifier: 'non existent identifier'
        }
      }

      post :cash_back, params: body

      expect(response.status).to eq(404)
    end
  end
end
