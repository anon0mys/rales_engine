class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.revenue_by_date(date)
    joins(:invoices => :invoice_items)
      .where('invoices.created_at = ?', date)
      .sum('quantity * unit_price')
  end
end
