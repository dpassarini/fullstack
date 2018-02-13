FactoryBot.define do
  factory :transfer_charge, class: 'Transfer' do
    value_cents 10000
    description "charge"
  end

  factory :transfer, class: 'Transfer' do
    value_cents 5000
    description "transfer"
  end

  factory :transfer_payment, class: 'Transfer' do
    value_cents -5000
    description "payment"
  end
end
