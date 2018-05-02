require 'rails_helper'

describe 'Item API Find Controller - All' do
  describe 'Find All JSON objects' do
    before(:each) do
      FactoryBot.reload
    end

    it 'can find items by names' do
      test_items = create_list(:item, 3, name: 'hammer')

      get '/api/v1/items/find_all?name=hammer'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end

    it 'can find items by description' do
      test_items = create_list(:item, 3, description: 'the best')

      get '/api/v1/items/find_all?description=the%20best'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end

    it 'can find items by unit price' do
      test_items = create_list(:item, 3, unit_price: 10)

      get '/api/v1/items/find_all?unit_price=10'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end

    it 'can find by merchant id' do
      merchant = create(:merchant)
      test_items = create_list(:item, 3, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end

    it 'can find all by created date' do
      test_items = create_list(:item, 3, created_at: '2018-04-30')

      get '/api/v1/items/find_all?created_at=04-30-2018'

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end

    it 'can find all by updated date' do
      test_items = create_list(:item, 3, updated_at: '2018-04-30')

      get '/api/v1/items/find_all?updated_at=04-30-2018'

      items = JSON.parse(response.body)

      expect(items.count).to eq(test_items.count)
    end
  end
end
