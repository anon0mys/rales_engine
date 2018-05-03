FactoryBot.define do
  factory :invoice do
    customer
    initialize_with { new(customer: customer) }
    association :merchant
    status "Pending"
  end
end
