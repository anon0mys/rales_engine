require 'rails_helper'

describe 'Customer Find API' do
  before(:each) do
    FactoryBot.reload
  end

  it 'can find a single customer by id' do
    test_customers = create_list(:customer, 4)

    get '/api/v1/customers/find?id=1'

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(test_customers.first.id)
  end


    it 'can find a single customer by first name' do
      create_list(:customer, 4)
      test_customer = create(:customer, first_name: 'Test')

      get '/api/v1/customers/find_all?first_name=test'

      expect(response).to be_successful

      customers = JSON.parse(response.body)

      expect(customers.first['first_name']).to eq(test_customer.first_name)
    end

    it 'can find a single customer by last name' do
      create_list(:customer, 4)
      test_customer = create(:customer, last_name: 'Test')

      get '/api/v1/customers/find_all?last_name=test'

      expect(response).to be_successful

      customers = JSON.parse(response.body)

      expect(customers.first['last_name']).to eq(test_customer.last_name)
    end

  it 'can find a single customer by created date' do
    create_list(:customer, 4)
    test_customer = create(:customer, created_at: '2018-04-30')

    get '/api/v1/customers/find?created_at=04-30-2018'

    expect(response).to be_successful

  customer = JSON.parse(response.body)

    expect(customer['id']).to eq(test_customer.id)
  end

  it 'can find a single customer by updated date' do
    create_list(:customer, 4)
    test_customer = create(:customer, updated_at: '2018-10-30')

    get '/api/v1/customers/find?updated_at=10-30-2018'

    expect(response).to be_successful

  customer = JSON.parse(response.body)

    expect(customer['id']).to eq(test_customer.id)
  end
end
