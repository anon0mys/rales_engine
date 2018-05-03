class Api::V1::Items::InvoicesController < ApplicationController
  def index
    render json: Item.find(params['item_id']).invoices
  end
end
