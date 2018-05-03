require 'rails_helper'

describe 'Invoice API Find Controller - All' do
  describe 'Find All JSON invoice item objects' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find invoice items by invoice id' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, invoice_id: 4)

      get '/api/v1/invoice_items/find_all?invoice_id=4'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end

    it 'can find invoice items by item id' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, item_id: 4)

      get '/api/v1/invoice_items/find_all?item_id=4'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end

    it 'can find invoice items by quanity' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, quantity: 8)
      test_invoice_items << create(:invoice_item, quantity: 8)

      get '/api/v1/invoice_items/find_all?quantity=8'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end

    it 'can find invoice items by unit_price' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, unit_price: 8)
      test_invoice_items << create(:invoice_item, unit_price: 8)

      get '/api/v1/invoice_items/find_all?unit_price=8'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(2)
    end

    it 'can find invoice items by unit_price' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, created_at: '2018-04-30')
      test_invoice_items << create(:invoice_item, created_at: '2018-04-30')
      test_invoice_items << create(:invoice_item, created_at: '2018-04-30')

      get '/api/v1/invoice_items/find_all?created_at=04-30-2018'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
    end

    it 'can find invoice items by unit_price' do
      test_invoice_items = create_list(:invoice_item, 4)
      test_invoice_items << create(:invoice_item, updated_at: '2018-04-30')
      test_invoice_items << create(:invoice_item, updated_at: '2018-04-30')
      test_invoice_items << create(:invoice_item, updated_at: '2018-04-30')

      get '/api/v1/invoice_items/find_all?updated_at=04-30-2018'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
    end
  end
end
