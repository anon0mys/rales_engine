require './lib/formatters/price_formatter'

class ItemSerializer < ActiveModel::Serializer
  include PriceFormatter
  attributes :id, :name, :description, :merchant_id, :unit_price
end
