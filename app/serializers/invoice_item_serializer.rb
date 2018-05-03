require './lib/formatters/price_formatter'

class InvoiceItemSerializer < ActiveModel::Serializer
  include PriceFormatter
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price
end
