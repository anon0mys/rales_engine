class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.revenue_by_date(date)
    joins(invoices: :invoice_items)
      .where('invoices.created_at = ?', date)
      .sum('quantity * unit_price')
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) AS item_count')
      .joins(invoices: :invoice_items)
      .group(:id)
      .order('item_count DESC')
      .limit(quantity)
  end
end
