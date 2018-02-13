require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe 'GET show' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:user2)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }
    let!(:child_account1)  { FactoryBot.create(:account, users: [user1], parent_account_id: parent_account.id) }
    let!(:child_account2)  { FactoryBot.create(:account, users: [user2], parent_account_id: parent_account.id) }
    let(:token) { double :acceptable? => true }

    before do
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    it 'should get the parent_account details' do
      get :show, params: {id: parent_account.id}
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body["id"]).to eq(parent_account.id)
    end

    it 'should not find any account' do
      get :show, params: {id: -1}
      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body).to eq({})
    end
  end

  describe 'POST create' do
    let!(:user1)  { FactoryBot.create(:user, email: Faker::Internet.email) }
    let!(:parent_account)  { FactoryBot.create(:account, users: [user1]) }
    let(:token) { double :acceptable? => true }

    before do
      allow(controller).to receive(:current_user) { user1 }
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    it 'should create an account to user1' do
      body = {
        account: {
          status: 'active',
          name: Faker::Company.name
        }
      }

      post :create, params: body
      expect(user1.accounts.count).to eq(2)
    end

    it 'should create a subaccount to parent_account' do
      body = {
        account: {
          status: 'active',
          name: Faker::Company.name,
          parent_account_id: parent_account.id
        }
      }

      post :create, params: body
      expect(parent_account.sub_accounts.count).to eq(1)
    end
  end
end
