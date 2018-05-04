require 'rails_helper'

describe 'Customer Business Intelligence API' do
  it 'returns a customer\'s favorite merchant' do
    DatabaseCleaner.clean
    customer = create(:customer)
    merchants = create_list(:merchant, 3)
    m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0], customer: customer)
    m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1], customer: customer)
    m3_invoices = create_list(:invoice, 5, created_at: '2018-03-03', merchant: merchants[2], customer: customer)
    m1_invoices.each do |invoice|
      create(:invoice_item, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    m2_invoices.each do |invoice|
      create(:invoice_item, invoice: invoice)
      create(:transaction, invoice: invoice)
    end
    m3_invoices.each do |invoice|
      create(:invoice_item, invoice: invoice)
      create(:transaction, invoice: invoice)
    end

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(favorite_merchant['id']).to eq(merchants[2]['id'])
    expect(favorite_merchant['name']).to eq(merchants[2]['name'])
  end
end
