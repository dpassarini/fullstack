FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password 'teste123'
    password_confirmation 'teste123'
    document CPF.generate
  end

  factory :user_person, class: 'User' do
    email Faker::Internet.email
    password 'teste123'
    password_confirmation 'teste123'
    document CPF.generate
  end

  factory :user_company, class: 'User' do
    email Faker::Internet.email
    password 'teste123'
    password_confirmation 'teste123'
    document CNPJ.generate
  end
end
