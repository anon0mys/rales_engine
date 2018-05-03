require 'rails_helper'

describe 'It can find favoite customer for a merchant' do
  it 'gives that customer with most succcessful invoices' do
    merchant = create(:merchant)
    customer = create(:customer)
    create(:customer)
    invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchant, customer: customer)
    other_invoice = create(:invoice, created_at: '2018-04-03', merchant: merchant)
    create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: invoices[0])
    create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: invoices[1])
    create_list(:invoice_item, 2, unit_price: 400, quantity: 1, invoice: invoices[2])
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: other_invoice)
    create(:transaction, invoice: invoices[0])
    create(:transaction, invoice: invoices[1])
    create(:transaction, invoice: invoices[2], result: 'failed')
    create(:transaction, invoice: other_invoice)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    fav_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(fav_customer['id']).to eq(customer.id)
  end
end
