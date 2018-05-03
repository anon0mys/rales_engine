class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def self.most_revenue(quantity)
    unscoped
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items, invoices: :transactions)
      .where(transactions: {result: 'success'})
      .group(:id)
      .order('revenue DESC')
      .limit(quantity);
  end

  def self.most_items(quantity)
    unscoped
      .select('items.*, sum(invoice_items.quantity) AS item_count')
      .joins(:invoice_items, invoices: :transactions)
      .where(transactions: {result: 'success'})
      .group(:id)
      .order('item_count DESC')
      .limit(quantity);
  end

  def best_day
    invoices.select('invoices.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS sales')
            .joins(:invoice_items, :transactions)
            .where(transactions: {result: 'success'})
            .group('date')
            .unscope(:order)
            .order('sales DESC, date ASC')
            .limit(1)
  end
end
