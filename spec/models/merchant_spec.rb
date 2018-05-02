require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    before(:each) do
      DatabaseCleaner.clean
      @merchants = create_list(:merchant, 2)
      m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: @merchants[0])
      m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: @merchants[1])
      create_list(:invoice_item, 3, unit_price: 200, invoice: m1_invoices[0])
      create_list(:invoice_item, 1, unit_price: 400, invoice: m1_invoices[1])
      create_list(:invoice_item, 2, unit_price: 500, invoice: m1_invoices[2])
      create_list(:invoice_item, 5, unit_price: 200, invoice: m2_invoices[0])
      create_list(:invoice_item, 2, unit_price: 250, invoice: m2_invoices[1])
    end

    after(:each) do
      DatabaseCleaner.clean
      FactoryBot.reload
    end

    it 'should return #revenue_by_date for all merchants' do
      expect(Merchant.revenue_by_date('03-03-2018')).to eq(3500)
    end

    it 'should return a merchant ranking of #most_items sold' do
      expect(Merchant.most_items(2).first).to eq(@merchants.last)
    end
  end
end
