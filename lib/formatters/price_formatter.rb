module PriceFormatter
  def unit_price
    (object.unit_price.to_f / 100).to_s
  end

  def revenue
    (object.to_f / 100).to_s
  end

  def total_revenue
    (object.to_f / 100).to_s
  end
end
