require 'rails_helper'

describe 'Random Transaction JSON' do
  it 'delivers a random transaction' do
    transactions = create_list(:transaction, 5)

    get '/api/v1/transactions/random.json'
    ids = [transactions[0].id, transactions[1].id, transactions[2].id, transactions[3].id, transactions[4].id]
    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(transaction['id'])
  end
end
