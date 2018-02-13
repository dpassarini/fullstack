require 'rails_helper'

RSpec.describe User, type: :model do
  context "Checking documents" do
    it 'should not validade an invalid document' do
      user = FactoryBot.build(:user, document: '123')
      expect(user.valid?).to be_falsey
    end

    it 'should validade a valid document' do
      user = FactoryBot.build(:user)
      expect(user.valid?).to be_truthy
    end

    it 'should validade a company document' do
      user = FactoryBot.build(:user_company)
      expect(user.valid?).to be_truthy
    end

    it 'should check if user is a company' do
      user = FactoryBot.build(:user_company)
      expect(user.is_company?).to be_truthy
      expect(user.is_person?).to be_falsey
    end

    it 'should check if user is a person' do
      user = FactoryBot.build(:user_person)
      expect(user.is_person?).to be_truthy
      expect(user.is_company?).to be_falsey
    end
  end
end
