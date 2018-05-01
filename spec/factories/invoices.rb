FactoryBot.define do
  factory :invoice do
    customer
    initialize_with { new(customer: customer) }
    merchant
    initialize_with { new(merchant: merchant) }
    status "Pending"
  end
end
