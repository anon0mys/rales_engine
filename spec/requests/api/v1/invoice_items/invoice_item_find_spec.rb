require 'rails_helper'

describe 'Invoice Search API' do
  describe 'Find Single JSON' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find a single invoice_item by id' do
      test_invoice_items = create_list(:invoice_item, 4)

      get '/api/v1/invoice_items/find?id=1'

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['id']).to eq(test_invoice_items.first.id)
    end

    it 'can find a single invoice_item by invoice_id' do
      test_invoice_items = create_list(:invoice_item, 4)

      get '/api/v1/invoice_items/find?invoice_id=4'

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['invoice_id']).to eq(test_invoice_items.last.invoice_id)
    end
  end

  it 'can find a single invoice_item by item_id' do
    test_invoice_items = create_list(:invoice_item, 4)

    get '/api/v1/invoice_items/find?item_id=4'

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item['item_id']).to eq(test_invoice_items.last.item_id)
  end

  it 'can find a single invoice_item by quanity' do
    test_invoice_items = create_list(:invoice_item, 4)
    test_invoice_items << create(:invoice_item, quantity: 88)

    get '/api/v1/invoice_items/find?quantity=88'

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item['quantity']).to eq(test_invoice_items.last.quantity)
  end

  it 'can find a single invoice_item by unit_price' do
    test_invoice_items = create_list(:invoice_item, 4)
    test_invoice_items << create(:invoice_item, unit_price: 88)

    get '/api/v1/invoice_items/find?unit_price=88'

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item['unit_price']).to eq(test_invoice_items.last.unit_price)
  end
end
