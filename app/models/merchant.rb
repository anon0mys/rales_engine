
class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  default_scope { order(:id) }

  def self.most_items(quantity)
    unscoped
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' })
      .order('sum(invoice_items.quantity) DESC')
      .group(:id)
      .limit(quantity)
  end

  def self.most_revenue(quantity)
    unscoped
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.revenue_by_date(filter)
    joins(invoices: [:invoice_items, :transactions])
      .where(filter)
      .merge(Transaction.unscoped.successful)
      .sum('quantity * unit_price')
  end

  def revenue(filter = {})
    invoices.joins(:invoice_items, :transactions)
      .where(filter)
      .merge(Transaction.unscoped.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def favorite_customer
    customers
      .joins(:transactions)
      .where(transactions: { result: 'Success' })
      .group(:id)
      .order('count(transactions.id) DESC')
      .limit(1)
      .first
  end

  def customers_with_pending_invoices
    # binding.pry
    customers.merge(Invoice.unpaid)
  end
end
