require 'rails_helper'

describe 'Merchant Business Intelligence API' do
  it 'returns total revenue for date for all merchants' do
    merchants = create_list(:merchant, 2)
    m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0])
    m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1])
    create_list(:invoice_item, 3, unit_price: 200, invoice: m1_invoices[0])
    create_list(:invoice_item, 1, unit_price: 400, invoice: m1_invoices[1])
    create_list(:invoice_item, 2, unit_price: 500, invoice: m1_invoices[2])
    create_list(:invoice_item, 5, unit_price: 200, invoice: m2_invoices[0])
    create_list(:invoice_item, 1, unit_price: 500, invoice: m2_invoices[1])

    get '/api/v1/merchants/revenue?date=03-03-2018'

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue).to eq(3500)
  end

  it 'returns count of items sold for merchants' do
    merchants = create_list(:merchant, 2)
    m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0])
    m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1])
    create_list(:invoice_item, 3, unit_price: 200, invoice: m1_invoices[0])
    create_list(:invoice_item, 1, unit_price: 400, invoice: m1_invoices[1])
    create_list(:invoice_item, 2, unit_price: 500, invoice: m1_invoices[2])
    create_list(:invoice_item, 5, unit_price: 200, invoice: m2_invoices[0])
    create_list(:invoice_item, 2, unit_price: 500, invoice: m2_invoices[1])

    get '/api/v1/merchants/most_items?quantity=2'

    ranking = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ranking.count).to eq(2)
    expect(ranking.keys.first.name).to eq(merchants[0].name)
  end
end
