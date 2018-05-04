require 'rails_helper'

describe 'Random Invoice JSON' do
  it 'delivers a random invoice' do
    invoices = create_list(:invoice, 5)

    get '/api/v1/invoices/random.json'
    ids = [invoices[0].id, invoices[1].id, invoices[2].id, invoices[3].id, invoices[4].id]
    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(invoice['id'])
  end
end
