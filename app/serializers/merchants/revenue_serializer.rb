class Merchants::RevenueSerializer < ActiveModel::Serializer
  attributes :revenue_by_date, :date

  def revenue_by_date
    binding.pry
  end
end
