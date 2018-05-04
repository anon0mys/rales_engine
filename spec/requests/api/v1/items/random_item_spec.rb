require 'rails_helper'

describe 'Random Item JSON' do
  it 'delivers a random item' do
    items = create_list(:item, 5)

    get '/api/v1/items/random.json'
    ids = [items[0].id, items[1].id, items[2].id, items[3].id, items[4].id]
    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(item['id'])
  end
end
