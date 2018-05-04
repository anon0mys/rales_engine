require 'rails_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'instance methods' do
    it 'returns the favorite merchant for a single customer' do
      DatabaseCleaner.clean
      customer = create(:customer)
      merchants = create_list(:merchant, 3)
      m1_invoices = create_list(:invoice, 3, created_at: '2018-03-03', merchant: merchants[0], customer: customer)
      m2_invoices = create_list(:invoice, 2, created_at: '2018-03-03', merchant: merchants[1], customer: customer)
      m3_invoices = create_list(:invoice, 5, created_at: '2018-03-03', merchant: merchants[2], customer: customer)
      m1_invoices.each do |invoice|
        create(:invoice_item, invoice: invoice)
        create(:transaction, invoice: invoice)
      end
      m2_invoices.each do |invoice|
        create(:invoice_item, invoice: invoice)
        create(:transaction, invoice: invoice)
      end
      m3_invoices.each do |invoice|
        create(:invoice_item, invoice: invoice)
        create(:transaction, invoice: invoice)
      end

      expect(customer.favorite_merchant).to eq(merchants[2])
    end
  end
end
