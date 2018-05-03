require './lib/formatters/price_formatter'

class MerchantRevenueSerializer < ActiveModel::Serializer
  include PriceFormatter
  attributes :revenue
end
