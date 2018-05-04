require 'rails_helper'

describe 'Transaction Search API' do
  describe 'single transactions' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find a single transaction by id' do
      test_transactions = create_list(:transaction, 4)

      get '/api/v1/transactions/find?id=1'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['id']).to eq(test_transactions.first.id)
    end

    it 'can find a single transaction by result' do
      create_list(:transaction, 4)
      test_transaction = create(:transaction, result: 'success')

      get '/api/v1/transactions/find?result=success'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['credit_card_number']).to eq(test_transaction.credit_card_number.to_s)
    end

    it 'can find a single transaction by credit_card_number' do
      create_list(:transaction, 4)
      test_transaction = create(:transaction, credit_card_number: 123)

      get '/api/v1/transactions/find?credit_card_number=123'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['credit_card_number']).to eq(test_transaction.credit_card_number.to_s)
    end

    it 'can find a single transaction by invoice_id' do
      test_transactions = create_list(:transaction, 4)

      get '/api/v1/transactions/find?invoice_id=1'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['invoice_id']).to eq(test_transactions.first.invoice_id)
    end

    it 'can find a single transaction by created date' do
      create_list(:transaction, 4)
      test_transaction = create(:transaction, created_at: '2018-04-30')

      get '/api/v1/transactions/find?created_at=04-30-2018'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['id']).to eq(test_transaction.id)
    end

    it 'can find a single transaction by updated date' do
      create_list(:transaction, 4)
      test_transaction = create(:transaction, updated_at: '2018-04-30')

      get '/api/v1/transactions/find?updated_at=04-30-2018'

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction['id']).to eq(test_transaction.id)
    end
  end
end
