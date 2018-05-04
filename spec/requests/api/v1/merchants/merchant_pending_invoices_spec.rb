require 'rails_helper'

describe 'Merchant Customers BI API' do
  it 'returns customers with pending invoices' do
    DatabaseCleaner.clean
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    invoice_1 = create(:invoice, created_at: '2018-03-03', merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, created_at: '2018-03-03', merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, created_at: '2018-03-03', merchant: merchant, customer: customer_2)
    invoice_4 = create(:invoice, created_at: '2018-04-03', merchant: merchant, customer: customer_2)
    invoice_5 = create(:invoice, created_at: '2018-04-03', merchant: merchant, customer: customer_3)
    create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: invoice_1)
    create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: invoice_2)
    create_list(:invoice_item, 2, unit_price: 400, quantity: 1, invoice: invoice_3)
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: invoice_4)
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: invoice_5)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3, result: 'failed')
    create(:transaction, invoice: invoice_4)
    create(:transaction, invoice: invoice_5, result: 'failed')
    create(:transaction, invoice: invoice_5)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    customers = JSON.parse(response.body)

    expect(customers.length).to eq(1)
    expect(customers.first['id']).to eq(customer_2.id)
  end
end
