require 'rails_helper'

describe 'Invoice API Find controller' do
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
