require './lib/formatters/price_formatter'

class TotalRevenueSerializer < ActiveModel::Serializer
  include PriceFormatter
  attributes :total_revenue
end
