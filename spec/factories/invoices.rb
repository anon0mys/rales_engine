FactoryBot.define do
  factory :invoice do
    association :customer
    association :merchant
    status "Pending"
  end
end
