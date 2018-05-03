require 'rails_helper'

describe 'Transaction API Find controller' do
  describe 'Find All JSON Objects' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find transactions by result' do
      create_list(:transaction, 4)
      create(:transaction, result: 'failure')

      get '/api/v1/transactions/find_all?result=success'

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(4)
    end

    it 'can find transactions by credit card number' do
      create_list(:transaction, 4)
      create(:transaction, credit_card_number: 123)

      get '/api/v1/transactions/find_all?credit_card_number=123'

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(1)
    end

    it 'can find multiple transactions by invoice_id' do
      create_list(:invoice, 2)
      create_list(:transaction, 4, invoice_id: 1)
      create_list(:transaction, 3, invoice_id: 2)

      get '/api/v1/transactions/find_all?invoice_id=2'

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
    end

    it 'can find multiple transactions by created date' do
      create_list(:transaction, 4)
      create_list(:transaction, 2, created_at: '2018-04-30')

      get '/api/v1/transactions/find_all?created_at=04-30-2018'

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end

    it 'can find a single transaction by updated date' do
      create_list(:transaction, 4)
      create_list(:transaction, 2, updated_at: '2018-04-30')

      get '/api/v1/transactions/find_all?updated_at=04-30-2018'

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end
  end
end
