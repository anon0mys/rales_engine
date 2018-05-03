require 'rails_helper'

describe 'InvoiceItem relationships API' do
  it 'outputs the InvoiceItem invoice' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expected_invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(expected_invoice['id']).to eq(invoice.id)
  end

  it 'outputs the InvoiceItem item' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expected_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(expected_item['id']).to eq(item.id)
  end
end
