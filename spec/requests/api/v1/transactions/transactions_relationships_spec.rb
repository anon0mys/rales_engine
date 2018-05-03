require 'rails_helper'

describe 'Transaction Relationship API Endpoints' do
  it 'outputs the invoice for a Transaction' do
    input_invoice = create(:invoice)
    transaction = create(:transaction, invoice: input_invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful

    expect(invoice['id']).to eq(input_invoice.id)
  end
end
