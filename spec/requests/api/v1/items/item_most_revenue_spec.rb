require 'rails_helper'

describe 'It can find most revenue for Items' do
  it 'shows the top two items by revenue' do
    merchants = create_list(:merchant, 3)
    customer = create(:customer)
    item = create(:item, name: "Tops",unit_price: 2, merchant: merchants[0])
    item_2 = create(:item, name: "Mids", unit_price: 20, merchant: merchants[1])
    item_3 = create(:item, name: "Bottom", unit_price: 2, merchant: merchants[2])
    invoice = create(:invoice, merchant: merchants[0], customer: customer, updated_at: "2018-02-03")
    invoice_2 = create(:invoice, merchant: merchants[1], customer: customer, updated_at: "2018-02-04")
    invoice_3 = create(:invoice, merchant: merchants[2], customer: customer, updated_at: "2018-02-04")

    create_list(:invoice_item, 10, item: item, invoice: invoice)
    create_list(:invoice_item, 2, item: item_2, invoice: invoice_2)
    create_list(:invoice_item, 1, item: item_3, invoice: invoice_3)
    create_list(:transaction, 10, invoice: invoice)
    create_list(:transaction, 3, invoice: invoice_2)
    create_list(:transaction, 1, invoice: invoice_3)

    get '/api/v1/items/most_revenue?quantity=2'

    items = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(items.first['id']).to eq(item.id)
  end
end
