class Api::V1::Merchants::FindController < ApplicationController
  before_action :search_params, only: [:index]

  def index
    binding.pry
    render json: Merchant.find_by(search_params)
  end

  private

  def search_params
    { params.keys.first.to_sym => params.values.first }
  end
end
