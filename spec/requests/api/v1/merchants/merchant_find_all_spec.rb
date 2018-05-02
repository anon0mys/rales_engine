require 'rails_helper'

describe 'Merchant Find All API' do
  before(:each) do
    FactoryBot.reload
  end

  it 'can find all merchants by id' do
    test_merchants = create_list(:merchant, 4)

    get '/api/v1/merchants/find_all?id=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.first['id']).to eq(test_merchants[2].id)
  end

  it 'can find all merchants by name' do
    test_merchants = create_list(:merchant, 4)

    get '/api/v1/merchants/find_all?name=Merchant%203'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.first['id']).to eq(test_merchants[2].id)
  end

  it 'can find all merchants by created date' do
    merchants = create_list(:merchant, 4, created_at: '2018-03-20')
    test_merchant = create(:merchant, created_at: '2018-04-30')

    get '/api/v1/merchants/find_all?created_at=03-20-2018'

    expect(response).to be_successful

    return_merchants = JSON.parse(response.body)

    expect(return_merchants.count).to eq(merchants.count)
  end

  it 'can find all merchants by updated date' do
    merchants = create_list(:merchant, 6, updated_at: '2018-04-20')
    test_merchant = create(:merchant, updated_at: '2018-04-30')

    get '/api/v1/merchants/find_all?updated_at=04-20-2018'

    expect(response).to be_successful

    return_merchants = JSON.parse(response.body)

    expect(return_merchants.count).to eq(merchants.count)
  end
end
