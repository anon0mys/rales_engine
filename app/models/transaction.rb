class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number, :result
  belongs_to :invoice

  scope :successful, -> { where(transactions: {result: 'success'}) }
end
