require 'rails_helper'

describe 'Customer Find All API' do
  before(:each) do
    FactoryBot.reload
  end

  it 'can find all customers by id' do
    test_customers = create_list(:customer, 4)

    get '/api/v1/customers/find_all?id=3'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.first['id']).to eq(test_customers[2].id)
  end

  it 'can find all customers by first name' do
    create_list(:customer, 4)
    customer_one = create(:customer, first_name: 'Test')
    customer_two = create(:customer, first_name: 'Test')

    get '/api/v1/customers/find_all?first_name=test'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.first['id']).to eq(customer_one.id)
    expect(customers.first['first_name']).to eq(customer_one.first_name)
    expect(customers[1]['id']).to eq(customer_two.id)
    expect(customers[1]['first_name']).to eq(customer_two.first_name)
  end

  it 'can find all customers by last name' do
    create_list(:customer, 4)
    customer_one = create(:customer, last_name: 'Test')
    customer_two = create(:customer, last_name: 'Test')

    get '/api/v1/customers/find_all?last_name=test'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.first['id']).to eq(customer_one.id)
    expect(customers.first['last_name']).to eq(customer_one.last_name)
    expect(customers[1]['id']).to eq(customer_two.id)
    expect(customers[1]['last_name']).to eq(customer_two.last_name)
  end

  it 'can find all customers by created date' do
    customers = create_list(:customer, 4, created_at: '2018-03-20')
    create(:customer, created_at: '2018-04-30')

    get '/api/v1/customers/find_all?created_at=03-20-2018'

    expect(response).to be_successful

    return_customers = JSON.parse(response.body)

    expect(return_customers.count).to eq(customers.count)
  end

  it 'can find all customers by updated date' do
    customers = create_list(:customer, 6, updated_at: '2018-04-20')
    create(:customer, updated_at: '2018-04-30')

    get '/api/v1/customers/find_all?updated_at=04-20-2018'

    expect(response).to be_successful

    return_customers = JSON.parse(response.body)

    expect(return_customers.count).to eq(customers.count)
  end
end
