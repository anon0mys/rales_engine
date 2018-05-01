require 'rails_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'requirements' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
  end
end
