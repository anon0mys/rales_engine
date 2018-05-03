require 'rails_helper'

describe 'Transaction API' do
  it 'outputs a list of transactions' do
    test_transactions = create_list(:transaction, 5)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(5)
  end

  it 'outputs a single transaction' do
    test_transaction = create(:transaction)

    get "/api/v1/transactions/#{test_transaction.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction['id']).to eq(test_transaction.id)
  end


    it 'creates a transaction' do
      invoice = create(:invoice)
      transaction_params = { credit_card_number: 123, result: 'success', invoice_id: invoice.id }

      post '/api/v1/transactions', params: { transaction: transaction_params }
      created_transaction = Transaction.last

      expect(response).to be_success

      expect(created_transaction['result']).to eq 'success'
      expect(created_transaction['credit_card_number']).to eq 123
    end

    it 'updates a transaction' do
      transaction_old = create(:transaction)

      transaction_params = { result: 'testing' }
      put "/api/v1/transactions/#{transaction_old.id}", params: { transaction: transaction_params }
      updated_transaction = Transaction.find(transaction_old.id)

      expect(response).to be_success
      expect(updated_transaction.result).to eq('testing')
    end

    it 'destroys a transaction' do
      transaction = create(:transaction)

      expect(Transaction.count).to eq(1)

      delete "/api/v1/transactions/#{transaction.id}"

      expect(response).to be_success
      expect(Transaction.count).to eq(0)
    end
end
