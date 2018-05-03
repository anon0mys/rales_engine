FactoryBot.define do
  factory :transaction do
    invoice nil
    credit_card_number 5555555555555555
    result "MyString"
  end
end
