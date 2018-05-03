class Api::V1::Transactions::FindController < ApplicationController
  def show
    render json: Transaction.find_by(search_params)
  end

  private

  def search_params
    { params.keys.first.to_sym => params.values.first }
  end
end
