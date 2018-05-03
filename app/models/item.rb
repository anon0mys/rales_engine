class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def self.most_revenue(quantity)
    unscoped
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoice_items)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity);
  end
end
