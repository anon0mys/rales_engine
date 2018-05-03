FactoryBot.define do
  factory :invoice_item do
    association :invoice
    association :item
    quantity 3
    unit_price 3
  end
end
