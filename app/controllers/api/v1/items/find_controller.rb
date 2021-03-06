class Api::V1::Items::FindController < FindController
  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private

  def search_params
    super.permit(:id,
                 :name,
                 :description,
                 :unit_price,
                 :merchant_id,
                 :created_at,
                 :updated_at)
  end
end
