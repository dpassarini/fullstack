FactoryBot.define do
  factory :account do
    name Faker::Company.name
    status 'active'
  end
end
