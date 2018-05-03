class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_by_date(params[:date]), serializer: RevenueSerializer
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.revenue(date_params), serializer: RevenueSerializer
  end

  private

  def date_params
    { created_at: params['date'] } unless params['date'].nil?
  end
end
