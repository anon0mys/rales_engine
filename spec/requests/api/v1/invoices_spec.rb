require 'rails_helper'

describe 'Invoice API' do
  it 'gives a list of invoices' do
    test_invoices = create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.size).to eq(test_invoices.size)
  end

  it 'gives a single invoice' do
    test_invoice = create(:invoice)
    id = test_invoice.id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["id"]).to eq(id)
  end

  it 'creates a single invoice' do
    create_list(:customers, 2)
    create_list(:merchants, 2)

    post "/api/v1/invoices/#{id}"
  end
end
