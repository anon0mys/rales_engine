require 'rails_helper'

describe 'Customer API' do
  it 'outputs a list of customers' do
    test_customers = create_list(:customer, 4)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(test_customers.count)
  end

  it 'outputs a single customer' do
    test_customer = create(:customer)

    get "/api/v1/customers/#{test_customer.id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(test_customer.id).to eq(customer['id'])
  end

  it 'creates a customer' do
    customer_params = { first_name: 'First', last_name: 'Last' }

    post '/api/v1/customers', params: { customer: customer_params }
    created_customer = Customer.last

    expect(response).to be_success
    expect(created_customer.first_name).to eq 'First'
    expect(created_customer.last_name).to eq 'Last'
  end

  it 'updates a customer' do
    customer_old = create(:customer)

    customer_params = { first_name: 'Testing', last_name: 'Changes' }
    put "/api/v1/customers/#{customer_old.id}", params: { customer: customer_params }
    updated_customer = Customer.find(customer_old.id)

    expect(response).to be_success
    expect(updated_customer.first_name).to_not eq(customer_old.first_name)
    expect(updated_customer.first_name).to eq('Testing')
    expect(updated_customer.last_name).to eq('Changes')
  end

  it 'destroys a customer' do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_success
    expect(Customer.count).to eq(0)
  end
end
