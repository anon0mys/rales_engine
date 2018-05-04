require 'rails_helper'

describe 'Random Invoice Item JSON' do
  it 'delivers a random invoice item' do
    invoice_items = create_list(:invoice_item, 5)

    get '/api/v1/invoice_items/random.json'
    ids = [invoice_items[0].id, invoice_items[1].id, invoice_items[2].id, invoice_items[3].id, invoice_items[4].id]
    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(invoice_item['id'])
  end
end
