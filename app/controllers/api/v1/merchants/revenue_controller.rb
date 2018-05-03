class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    filter = date_parser(params[:date])
    render json: Merchant.revenue_by_date(filter), serializer: TotalRevenueSerializer
  end

  def show
    filter = date_parser(params[:date]) unless params[:date].nil?
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.revenue(filter), serializer: MerchantRevenueSerializer
  end

  private

  def date_parser(date_filter)
    date = DateTime.parse(date_filter)
    { invoices: { created_at: date.beginning_of_day..date.end_of_day }}
  end
end
