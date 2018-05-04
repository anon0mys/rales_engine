require 'rails_helper'

describe 'Random Customer JSON' do
  it 'delivers a random customer' do
    customers = create_list(:customer, 5)

    get '/api/v1/customers/random.json'
    ids = [customers[0].id, customers[1].id, customers[2].id, customers[3].id, customers[4].id]
    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(ids).to include(customer['id'])
  end
end
