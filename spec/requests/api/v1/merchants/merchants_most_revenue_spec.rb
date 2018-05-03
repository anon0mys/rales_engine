require 'rails_helper'

describe 'It can find most revenue for merchants' do
  it 'shows the top two merchants by revenue' do
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

    get '/api/v1/merchants/most_revenue?quantity=2'

    output_merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(output_merchants.first['id']).to eq(merchants[0].id)
    expect(output_merchants.size).to eq(2)
  end
end
