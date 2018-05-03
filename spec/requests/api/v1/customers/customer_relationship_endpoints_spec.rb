require 'rails_helper'

describe 'Customer relationships API' do
  it 'outputs a customer\'s transactions' do
    customer = create(:customer)
    invoices = create_list(:invoice, 5, customer: customer)
    transactions = create_list(:transaction, 2, invoice: invoices[0])
    transactions << create_list(:transaction, 2, invoice: invoices[1])
    transactions << create_list(:transaction, 2, invoice: invoices[2])
    transactions << create_list(:transaction, 2, invoice: invoices[3])
    transactions << create_list(:transaction, 2, invoice: invoices[4])

    get "/api/v1/customers/#{customer.id}/transactions"

    customer_transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_transactions.count).to eq(transactions.flatten.count)
  end

  it 'outputs a customer\'s invoices' do
    customer = create(:customer)
    invoices = create_list(:invoice, 5, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    customer_invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_invoices.count).to eq(invoices.count)
  end
end
