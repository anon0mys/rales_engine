require 'rails_helper'

describe 'Random Merchant JSON' do
  it 'delivers a random merchant' do
    merchants = create_list(:merchant, 5)

    get '/api/v1/merchants/random.json'
    ids = [merchants[0].id, merchants[1].id, merchants[2].id, merchants[3].id, merchants[4].id]
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(merchant['id'])
  end
end
