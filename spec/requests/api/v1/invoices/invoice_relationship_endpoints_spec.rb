require 'rails_helper'

describe 'Invoice Search API' do
  describe 'Find Single JSON' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can show transactions for an invoice' do
      invoice = create(:invoice)
      input_transactions = create_list(:transaction, 5, invoice: invoice)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.size).to eq(input_transactions.size)
    end

    it 'can show invoice_items for an invoice' do
      invoice = create(:invoice)
      input_invoice_items = create_list(:invoice_item, 5, invoice: invoice)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.size).to eq(input_invoice_items.size)
    end

    it 'can show all items for an invoice' do
      invoice = create(:invoice)
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      create(:invoice_item, invoice: invoice, item: item1)
      create(:invoice_item, invoice: invoice, item: item2)
      create(:invoice_item, invoice: invoice, item: item3)
      input_items = Item.all

      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.size).to eq(input_items.size)
    end

    it 'can show the customer for an item' do
      input_customer = create(:customer)
      invoice = create(:invoice, customer: input_customer)

      get "/api/v1/invoices/#{invoice.id}/customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer['id']).to eq(input_customer.id)
    end

    it 'can show the merchant for an item' do
      input_merchant = create(:merchant)
      invoice = create(:invoice, merchant: input_merchant)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant['id']).to eq(input_merchant.id)
    end
  end
end
