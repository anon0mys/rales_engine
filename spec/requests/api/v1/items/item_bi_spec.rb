require 'rails_helper'

describe 'Item Business Intelligence API' do
  before(:each) do
    merchants = create_list(:merchant, 3)
    customer = create(:customer)
    @item = create(:item, name: "Tops", unit_price: 2, merchant: merchants[0])
    @item_2 = create(:item, name: "Mids", unit_price: 20, merchant: merchants[1])
    @item_3 = create(:item, name: "Bottom", unit_price: 2, merchant: merchants[2])
    invoice = create(:invoice, merchant: merchants[0], customer: customer, updated_at: "2018-02-03")
    invoice_2 = create(:invoice, merchant: merchants[1], customer: customer, updated_at: "2018-02-04")
    invoice_3 = create(:invoice, merchant: merchants[2], customer: customer, updated_at: "2018-02-04")

    create_list(:invoice_item, 10, unit_price: 2, item: @item, invoice: invoice)
    create_list(:invoice_item, 5, unit_price: 20, item: @item_2, invoice: invoice_2)
    create_list(:invoice_item, 1, unit_price: 2, item: @item_3, invoice: invoice_3)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)
  end

  it 'shows the top two items by revenue' do
    get '/api/v1/items/most_revenue?quantity=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.first['id']).to eq(@item_2.id)
  end

  it 'shows the top number of items by items sold' do
    get '/api/v1/items/most_items?quantity=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.first['id']).to eq(@item.id)
  end

  it 'should return the best day for a single item' do
    DatabaseCleaner.clean
    merchants = create_list(:merchant, 3)
    customer = create(:customer)
    item = create(:item, name: "Tops", unit_price: 2, merchant: merchants[0])
    invoice = create(:invoice, merchant: merchants[0], customer: customer, created_at: "2018-02-03")
    invoice_2 = create(:invoice, merchant: merchants[1], customer: customer, created_at: "2018-02-04")
    invoice_3 = create(:invoice, merchant: merchants[2], customer: customer, created_at: "2018-02-04")

    create_list(:invoice_item, 10, item: item, invoice: invoice)
    create_list(:invoice_item, 10, item: item, invoice: invoice_2)
    create_list(:invoice_item, 8, item: item, invoice: invoice_3)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)

    get '/api/v1/items/1/best_day'

    best_day = JSON.parse(response.body)

    expect(response).to be_successful
    expect(best_day['best_day'][0...10]).to eq('2018-02-04')
  end
end
