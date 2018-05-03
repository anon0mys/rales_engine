FactoryBot.define do
  factory :invoice_item do
<<<<<<< HEAD
    invoice nil
    item nil
    quantity 3
    unit_price 3
=======
    association :invoice
    association :item
    quantity 1
    unit_price 1
>>>>>>> Invoice Item endpoints complete. About to do find controller.
  end
end
