class Api::V1::Items::FindController < ApplicationController
  before_action :search_params, only: [:show, :index]

  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private

  def search_params
    { params.keys.first.to_sym => params.values.first }
  end
end
