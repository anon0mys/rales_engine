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
    it 'should return the total revenue for a date' do
      merchants = create_list(:merchant, 2)
      m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0])
      m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1])
      create_list(:invoice_item, 3, unit_price: 200, invoice: m1_invoices[0])
      create_list(:invoice_item, 1, unit_price: 400, invoice: m1_invoices[1])
      create_list(:invoice_item, 2, unit_price: 500, invoice: m1_invoices[2])
      create_list(:invoice_item, 5, unit_price: 200, invoice: m2_invoices[0])
      create_list(:invoice_item, 1, unit_price: 500, invoice: m2_invoices[1])

      expect(Merchant.revenue_by_date('03-03-2018')).to eq(3500)
    end
  end
end
