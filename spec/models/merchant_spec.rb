require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'class methods' do
    before(:each) do
      DatabaseCleaner.clean
      @merchants = create_list(:merchant, 2)
      m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: @merchants[0])
      m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: @merchants[1])
      create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: m1_invoices[0])
      create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: m1_invoices[1])
      create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: m1_invoices[2])
      create_list(:invoice_item, 5, unit_price: 200, quantity: 1, invoice: m2_invoices[0])
      create_list(:invoice_item, 2, unit_price: 250, quantity: 1, invoice: m2_invoices[1])
      create(:transaction, invoice: m1_invoices[0])
      create(:transaction, invoice: m1_invoices[1])
      create(:transaction, invoice: m1_invoices[2])
      create(:transaction, invoice: m2_invoices[0])
      create(:transaction, invoice: m2_invoices[1])
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    it 'should return #revenue_by_date for all merchants' do
      date = DateTime.parse('03-03-2018')
      expect(Merchant.revenue_by_date({ invoices: { created_at: date.beginning_of_day..date.end_of_day }})).to eq(3500)
    end

    it 'should return a merchant ranking of #most_items sold' do
      expect(Merchant.most_items(2).first).to eq(@merchants.last)
    end

    it 'should return merchants by revenue' do
      merchant = Merchant.most_revenue(1)
      expect(merchant[0].id).to eq(@merchants.first.id)
    end
  end

  describe 'instance methods' do
    before(:each) do
      DatabaseCleaner.clean
      @merchant = create(:merchant)
      @customer = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      invoice_1 = create(:invoice, created_at: '2018-03-03', merchant: @merchant, customer: @customer)
      invoice_2 = create(:invoice, created_at: '2018-03-03', merchant: @merchant, customer: @customer)
      invoice_3 = create(:invoice, created_at: '2018-03-03', merchant: @merchant, customer: @customer_2)
      invoice_4 = create(:invoice, created_at: '2018-04-03', merchant: @merchant, customer: @customer_2)
      invoice_5 = create(:invoice, created_at: '2018-04-03', merchant: @merchant, customer: @customer_3)
      create_list(:invoice_item, 3, unit_price: 200, quantity: 1, invoice: invoice_1)
      create_list(:invoice_item, 1, unit_price: 400, quantity: 1, invoice: invoice_2)
      create_list(:invoice_item, 2, unit_price: 400, quantity: 1, invoice: invoice_3)
      create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: invoice_4)
      create_list(:invoice_item, 2, unit_price: 500, quantity: 1, invoice: invoice_5)
      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3, result: 'failed')
      create(:transaction, invoice: invoice_4)
      create(:transaction, invoice: invoice_5, result: 'failed')
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    it 'should return #revenue by date for a merchant' do
      expect(@merchant.revenue).to eq(2000)
    end

    it 'should return #revenue for a single merchant' do
      expect(@merchant.revenue({'created_at' =>'03-03-2018' })).to eq(1000)
    end

    it 'should return the merchants favorite customer' do
      customer = @merchant.favorite_customer
      expect(customer['id']).to eq(@customer.id)
    end

    it 'should return the customers with pending invoices for a merchant' do
      customers = @merchant.customers_with_pending_invoices

      expect(customers.length).to eq(2)
      expect(customers.first['id']).to eq(@customer_2.id)
      expect(customers.last['id']).to eq(@customer_3.id)
    end
  end
end
