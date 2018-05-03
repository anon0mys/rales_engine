FactoryBot.define do
  factory :invoice_item do
    invoice nil
    item nil
    quantity 3
    unit_price 3
  end
end
