class Api::V1::Merchants::FindController < ApplicationController
  before_action :search_params, only: [:index]

  def show
    render json: Merchant.find_by(search_params)
  end

  def index
    render json: Merchant.where(search_params)
  end

  private

  def search_params
    { params.keys.first.to_sym => params.values.first }
  end
end
