require 'rails_helper'

describe 'Merchant relationships API' do
  it 'outputs a merchant\'s items' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    merchant_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_items.count).to eq(items.count)
  end

  it 'outputs a merchant\'s invoices' do
    merchant = create(:merchant)
    invoice = create_list(:invoice, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    merchant_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_invoices.count).to eq(invoice.count)
  end
end
