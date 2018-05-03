FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number 5555555555555555
    result 'success'
  end
end
