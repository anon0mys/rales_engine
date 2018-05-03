require 'rails_helper'

describe 'Item Relationships API Endpoints' do
  it 'outputs the invoice_items for the item' do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 5, item: item)

    get "/api/v1/items/#{item.id}/invoices"

    expected_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful

    expect(expected_invoice_items.size).to eq(invoice_items.size)
  end

  it 'outputs the merchant for the item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expected_merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expect(expected_merchant['id']).to eq(merchant.id)
  end
end
