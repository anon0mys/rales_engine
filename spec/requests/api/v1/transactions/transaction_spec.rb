require 'rails_helper'

describe 'Transaction API' do
  it 'outputs a list of transactions' do
    test_transactions = create_list(:transaction, 5)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
  end
end
