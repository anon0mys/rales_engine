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

  it 'creates an invoice' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_params = { customer_id: customer.id, merchant_id: merchant.id,  status: "Pending"}

    post '/api/v1/invoices/', params: { invoice: invoice_params }
    created_invoice = Invoice.all.last

    expect(response).to be_success
    expect(created_invoice.customer_id).to eq(customer.id)
    expect(created_invoice.merchant_id).to eq(merchant.id)
    expect(created_invoice.status).to eq('Pending')
  end

  it 'updates an invoice' do
    invoice = create(:invoice)

    invoice_params = { status: "Sold"}
    put "/api/v1/invoices/#{invoice.id}", params: { invoice: invoice_params }
    updated_invoice = Invoice.find(invoice.id)

    expect(response).to be_success
    expect(invoice.status).to_not eq(updated_invoice.status)
    expect(updated_invoice.status).to eq('Sold')
  end

  it 'deletes an invoice' do
    invoice = create(:invoice)

    expect(Invoice.all.count).to eq(1)

    delete "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_success
    expect(Item.count).to eq(0)
  end
end
