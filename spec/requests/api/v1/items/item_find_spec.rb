require 'rails_helper'

describe 'Item Search API' do
  describe 'Find Single JSON item' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find a single item by id' do
      test_items = create_list(:item, 4)

      get '/api/v1/items/find?id=1'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(test_items.first.id)
    end

    it 'can find a single item by name' do
      create_list(:item, 4)
      test_item = create(:item, name: 'sledge')

      get '/api/v1/items/find?name=sledge'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(test_item.id)
    end

    it 'can find a single item by description' do
      create_list(:item, 4)
      test_item = create(:item, description: 'hammer')

      get '/api/v1/items/find?description=hammer'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(test_item.id)
    end

    it 'can find a single item by merchant_id' do
      test_items = create_list(:item, 4)

      get '/api/v1/items/find?merchant_id=1'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['merchant_id']).to eq(test_items.first.merchant_id)
    end

    it 'can find a single item by created date' do
      create_list(:item, 4)
      test_item = create(:item, created_at: '2018-04-30')

      get '/api/v1/items/find?created_at=04-30-2018'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(test_item.id)
    end

    it 'can find a single item by created date' do
      create_list(:item, 4)
      test_item = create(:item, updated_at: '2018-04-30')

      get '/api/v1/items/find?updated_at=04-30-2018'

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(test_item.id)
    end
  end
end
