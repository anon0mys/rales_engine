class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  default_scope { order(:id) }

  def self.revenue_by_date(date)
    joins(invoices: :invoice_items)
      .where('invoices.created_at = ?', date)
      .sum('quantity * unit_price')
  end

  def self.most_items(quantity)
    unscoped
      .select('merchants.*, sum(invoice_items.quantity) AS item_count')
      .joins(invoices: :invoice_items)
      .group(:id)
      .order('item_count DESC')
      .limit(quantity)
  end

  def revenue(filter = {})
    invoices.joins(:invoice_items, :transactions)
      .where(filter)
      .merge(Transaction.unscoped.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
