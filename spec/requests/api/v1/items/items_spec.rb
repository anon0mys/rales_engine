require 'rails_helper'

describe 'Items API' do
  it 'gives a list of items' do
    test_items = create_list(:item, 5)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.size).to eq(test_items.size)
  end

  it 'gives a single item' do
    test_item = create(:item)
    id = test_item.id

    get "/api/v1/items/#{id}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item["id"]).to eq(id)
  end

  it 'creates an item' do
    merchant = create(:merchant)
    item_params = { name: 'candle',
                    description: 'light',
                    unit_price: 3,
                    merchant_id: merchant.id }

    post '/api/v1/items/', params: { item: item_params }
    created_item = Item.all.last

    expect(response).to be_success
    expect(created_item.name).to eq('candle')
    expect(created_item.description).to eq('light')
    expect(created_item.unit_price).to eq(3)
    expect(created_item.merchant_id).to eq(merchant.id)
  end

  it 'updates an item' do
    old_item = create(:item)
    item_params = { name: 'candle',
                    description: 'light',
                    unit_price: 3 }

    put "/api/v1/items/#{old_item.id}", params: { item: item_params }
    updated_item = Item.find(old_item.id)

    expect(response).to be_success
    expect(updated_item.name).to eq('candle')
    expect(updated_item.description).to eq('light')
    expect(updated_item.unit_price).to eq(3)
  end

  it 'deletes an item' do
    item = create(:item)

    expect(Item.all.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_success
    expect(Item.count).to eq(0)
  end
end
