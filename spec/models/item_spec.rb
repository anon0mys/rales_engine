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
    it { should have_many(:invoices).through(:invoice_items) }
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

      create_list(:invoice_item, 10, unit_price: 2, item: @item, invoice: @invoice)
      create_list(:invoice_item, 5, unit_price: 20, item: @item_2, invoice: @invoice_2)
      create_list(:invoice_item, 8, unit_price: 2, item: @item_3, invoice: @invoice_3)
      create(:transaction, invoice: @invoice)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
    end

    it 'can find items with most revenue' do
      items = Item.most_revenue(2)
      expect(items.first).to eq(@item_2)
      expect(items.last).to eq(@item)
    end

    it 'can find items with most items sold' do
      items = Item.most_items(2)
      expect(items.first).to eq(@item)
      expect(items.last).to eq(@item_3)
    end
  end

  describe 'Instance Methods' do
    it 'can find the best day for an item' do
      merchants = create_list(:merchant, 3)
      customer = create(:customer)
      item = create(:item, name: "Tops",unit_price: 2, merchant: merchants[0])
      invoice = create(:invoice, merchant: merchants[0], customer: customer, created_at: "2018-02-03")
      invoice_2 = create(:invoice, merchant: merchants[1], customer: customer, created_at: "2018-02-04")
      invoice_3 = create(:invoice, merchant: merchants[2], customer: customer, created_at: "2018-02-04")

      create_list(:invoice_item, 10, item: item, invoice: invoice)
      create_list(:invoice_item, 10, item: item, invoice: invoice_2)
      create_list(:invoice_item, 8, item: item, invoice: invoice_3)
      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3)

      expect(item.best_day[0].date).to eq(DateTime.parse('2018-02-04'))
    end
  end
end
