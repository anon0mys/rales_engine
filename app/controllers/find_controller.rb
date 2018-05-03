class FindController < ApplicationController
  def unformat_price(price)
    price.gsub('.', '').to_i
  end

  def search_params
    params[:unit_price] = unformat_price(params[:unit_price]) if params[:unit_price]
    params
  end
end
