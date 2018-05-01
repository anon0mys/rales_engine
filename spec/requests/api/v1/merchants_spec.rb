require 'rails_helper'

describe 'Merchant API' do
  it 'outputs a list of merchants' do
    test_merchants = create_list(:merchant, 4)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(test_merchants.count)
  end

  it 'outputs a single merchant' do
    test_merchant = create(:merchant)

    get "/api/v1/merchants/#{test_merchant.id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(test_merchant.id).to eq(merchant['id'])
  end

  it 'creates a merchant' do
    merchant_params = { name: 'Name' }

    post '/api/v1/merchants', params: { merchant: merchant_params }
    created_merchant = Merchant.last

    expect(response).to be_success
    expect(created_merchant.name).to eq 'Name'
  end

  it 'updates a merchant' do
    merchant_old = create(:merchant)

    merchant_params = { name: 'Testing Changes' }
    put "/api/v1/merchants/#{merchant_old.id}", params: { merchant: merchant_params }
    updated_merchant = Merchant.find(merchant_old.id)

    expect(response).to be_success
    expect(updated_merchant.name).to_not eq(merchant_old.name)
    expect(updated_merchant.name).to eq('Testing Changes')
  end

  it 'destroys a merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success
    expect(Merchant.count).to eq(0)
  end
end
