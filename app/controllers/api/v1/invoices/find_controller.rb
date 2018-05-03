class Api::V1::Invoices::FindController < ApplicationController
  def show
    render json: Invoice.find_by(search_params)
  end

  def index
    render json: Invoice.where(search_params)
  end

  private

  def search_params
    # { params.keys.first.to_sym => params.values.first }
    params.permit(:id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at)
  end
end
