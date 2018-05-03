require 'rails_helper'

describe 'Merchant Business Intelligence API' do
  before(:each) do
    DatabaseCleaner.clean
    FactoryBot.reload
  end

  it 'returns total revenue for date for all merchants' do
    merchants = create_list(:merchant, 2)
    m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0])
    m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1])
    create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: m1_invoices[0])
    create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: m1_invoices[1])
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: m1_invoices[2])
    create_list(:invoice_item, 5, unit_price: 200, quantity: 1, invoice: m2_invoices[0])
    create_list(:invoice_item, 1, unit_price: 500, quantity: 1, invoice: m2_invoices[1])
    create(:transaction, invoice: m1_invoices[0])
    create(:transaction, invoice: m1_invoices[1])
    create(:transaction, invoice: m1_invoices[2])
    create(:transaction, invoice: m2_invoices[0])
    create(:transaction, invoice: m2_invoices[1])

    get '/api/v1/merchants/revenue?date=03-03-2018'

    revenue = JSON.parse(response.body)
    expected = { 'total_revenue' => '35.0' }

    expect(response).to be_successful
    expect(revenue).to eq(expected)
  end

  it 'returns count of items sold for merchants' do
    merchants = create_list(:merchant, 2)
    m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0])
    m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1])
    create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: m1_invoices[0])
    create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: m1_invoices[1])
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: m1_invoices[2])
    create_list(:invoice_item, 5, unit_price: 200, quantity: 1, invoice: m2_invoices[0])
    create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: m2_invoices[1])

    get '/api/v1/merchants/most_items?quantity=2'

    ranking = JSON.parse(response.body)

    expect(response).to be_successful
    expect(ranking.count).to eq(2)
    expect(ranking.first['name']).to eq(merchants[1].name)
  end

  describe 'single merchant business intelligence API' do
    before(:each) do
      DatabaseCleaner.clean
      @merchant = create(:merchant)
      invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: @merchant)
      other_invoice = create(:invoice, created_at: '2018-04-03', merchant: @merchant)
      create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: invoices[0])
      create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: invoices[1])
      create_list(:invoice_item, 2, unit_price: 400, quantity: 1, invoice: invoices[2])
      create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: other_invoice)
      create(:transaction, invoice: invoices[0])
      create(:transaction, invoice: invoices[1])
      create(:transaction, invoice: invoices[2], result: 'failed')
      create(:transaction, invoice: other_invoice)
    end

    it 'returns total revenue for a single merchant' do
      get "/api/v1/merchants/#{@merchant.id}/revenue"

      revenue = JSON.parse(response.body)
      expected = { 'revenue' => '20.0' }

      expect(response).to be_successful
      expect(revenue).to eq(expected)
    end

    it 'returns revenue for a single merchant by date' do
      get "/api/v1/merchants/#{@merchant.id}/revenue?date=03-03-2018"

      revenue = JSON.parse(response.body)
      expected = { 'revenue' => '10.0' }

      expect(response).to be_successful
      expect(revenue).to eq(expected)
    end
  end
end
