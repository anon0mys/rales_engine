require 'rails_helper'

describe 'Invoice API' do
  it 'gives a list of invoices' do
    create(:customer)
    test_invoices = create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.size).to eq(test_invoices.size)
  end
end
