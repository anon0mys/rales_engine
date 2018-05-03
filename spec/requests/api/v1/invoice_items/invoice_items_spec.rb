require 'rails_helper'

describe 'InvoiceItems API' do
  it 'gives a list of invoice_items' do
    test_invoice_items = create_list(:invoice_item, 5)

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.size).to eq(test_invoice_items.size)
  end

  it 'gives a single invoice_item' do
    test_invoice_item = create(:invoice_item)
    id = test_invoice_item.id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["id"]).to eq(id)
  end

  it 'creates an invoice_item' do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item_params = {invoice_id: invoice.id, item_id: item.id, quantity: 10, unit_price: 8 }

    post '/api/v1/invoice_items/', params: { invoice_item: invoice_item_params }
    created_invoice_item = InvoiceItem.all.last

    expect(response).to be_success
    expect(created_invoice_item.invoice_id).to eq(invoice.id)
    expect(created_invoice_item.item_id).to eq(item.id)
    expect(created_invoice_item.quantity).to eq(10)
    expect(created_invoice_item.unit_price).to eq(8)
  end

  it 'updates an invoice_item' do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = create(:invoice_item)

    invoice_item_params = {invoice_id: invoice.id, item_id: item.id, quantity: 10, unit_price: 8 }

    put "/api/v1/invoice_items/#{invoice_item.id}", params: { invoice_item: invoice_item_params }
    updated_invoice_item = InvoiceItem.find(invoice_item.id)

    expect(response).to be_success
    expect(updated_invoice_item.invoice_id).to eq(invoice.id)
    expect(updated_invoice_item.item_id).to eq(item.id)
    expect(updated_invoice_item.quantity).to eq(10)
    expect(updated_invoice_item.unit_price).to eq(8)
  end

  it 'deletes an invoice_item' do
    invoice_item = create(:invoice_item)

    expect(InvoiceItem.all.count).to eq(1)

    delete "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_success
    expect(InvoiceItem.count).to eq(0)
  end
end
