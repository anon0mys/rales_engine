require 'rails_helper'

describe 'Merchant relationships API' do
  it 'should generate a list of merchant items' do
    merchant = create(:merchant)
    items = create_list(:item, 10, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    merchant_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.items.count).to eq(10)
  end
end
