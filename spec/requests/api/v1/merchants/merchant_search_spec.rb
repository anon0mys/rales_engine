require 'rails_helper'

describe 'Merchant Search API' do
  before(:each) do
    FactoryBot.reload
  end

  it 'can find a single merchant by id' do
    test_merchants = create_list(:merchant, 4)

    get '/api/v1/merchants/find?id=1'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(test_merchants.first.id)
  end

  it 'can find a single merchant by name' do
    test_merchants = create_list(:merchant, 4)

    get '/api/v1/merchants/find?name=merchant%201'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['name']).to eq(test_merchants.first.name)
  end

  it 'can find a single merchant by created date' do
    create_list(:merchant, 4)
    test_merchant = create(:merchant, created_at: '2018-04-30')

    get '/api/v1/merchants/find?created_at=04-30-2018'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(test_merchant.id)
  end

  it 'can find a single merchant by updated date' do
    create_list(:merchant, 4)
    test_merchant = create(:merchant, updated_at: '2018-10-30')

    get '/api/v1/merchants/find?updated_at=10-30-2018'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(test_merchant.id)
  end
end
