require 'rails_helper'

describe Item do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'Relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices) }
  end

  describe 'Class Methods' do
    before(:each) do
      @merchants = create_list(:merchant, 3)
      @customer = create(:customer)
      @item = create(:item, name: "Tops",unit_price: 2, merchant: @merchants[0])
      @item_2 = create(:item, name: "Mids", unit_price: 20, merchant: @merchants[1])
      @item_3 = create(:item, name: "Bottom", unit_price: 2, merchant: @merchants[2])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer, updated_at: "2018-02-04")
      @invoice_3 = create(:invoice, merchant: @merchants[2], customer: @customer, updated_at: "2018-02-04")

      create_list(:invoice_item, 10, item: @item, invoice: @invoice)
      create_list(:invoice_item, 2, item: @item_2, invoice: @invoice_2)
      create_list(:invoice_item, 1, item: @item_3, invoice: @invoice_3)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
      create_list(:transaction, 1, invoice: @invoice_3)
    end

    it 'can find items with most revenue' do
      # expect(Item.most_revenue(2)).to eq([@item, @item_2])
    end
  end
end
