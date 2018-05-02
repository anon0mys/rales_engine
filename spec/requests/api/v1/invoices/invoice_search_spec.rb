require 'rails_helper'

describe 'Invoice Search API' do
  describe 'Find Single JSON' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find a single invoice by id' do
      test_invoices = create_list(:invoice, 4)

      get '/api/v1/invoices/find?id=1'

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(test_invoices.first.id)
    end

    it 'can find a single invoice by customer_id' do
      test_invoices = create_list(:invoice, 4)

      get '/api/v1/invoices/find?customer_id=1'

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['customer_id']).to eq(test_invoices.first.customer_id)
    end

    it 'can find a single invoice by merchant_id' do
      test_invoices = create_list(:invoice, 4)

      get '/api/v1/invoices/find?merchant_id=1'

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['merchant_id']).to eq(test_invoices.first.merchant_id)
    end

    it 'can find a single invoice by created date' do
      create_list(:invoice, 4)
      test_invoice = create(:invoice, created_at: '2018-04-30')

      get '/api/v1/invoices/find?created_at=04-30-2018'

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(test_invoice.id)
    end

    it 'can find a single invoice by updated date' do
      create_list(:invoice, 4)
      test_invoice = create(:invoice, updated_at: '2018-04-30')

      get '/api/v1/invoices/find?updated_at=04-30-2018'

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(test_invoice.id)
    end
  end

  describe 'Find All JSON Objects' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find invoices by customer_id' do
      test_invoices = create_list(:invoice, 4)
      test_invoices << create(:invoice, customer_id: 1)

      get '/api/v1/invoices/find_all?customer_id=1'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end

    it 'can find multiple invoices by merchant_id' do
      test_invoices = create_list(:invoice, 4)
      test_invoices << create(:invoice, merchant_id: 1)

      get '/api/v1/invoices/find_all?merchant_id=1'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end

    it 'can find multiple invoices by created date' do
      create_list(:invoice, 4)
      create(:invoice, created_at: '2018-04-30')
      create(:invoice, created_at: '2018-04-30')

      get '/api/v1/invoices/find_all?created_at=04-30-2018'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end

    it 'can find a single invoice by updated date' do
      create_list(:invoice, 4)
      create(:invoice, updated_at: '2018-04-30')
      create(:invoice, updated_at: '2018-04-30')

      get '/api/v1/invoices/find_all?updated_at=04-30-2018'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(2)
    end
  end
end
