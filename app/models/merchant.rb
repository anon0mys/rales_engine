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
    joins(:invoices => :invoice_items)
      .group('merchant_id')
      .count('invoice_items.quantity')
      .order('item_count DESC')
      .limit(quantity)
  end
end
