class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, count(transactions.id) AS transaction_count')
      .joins(invoices: :transactions)
      .merge(Transaction.unscoped.successful)
      .group('merchants.id')
      .unscope(:order)
      .order('transaction_count DESC')
      .limit(1)[0]
  end
end
