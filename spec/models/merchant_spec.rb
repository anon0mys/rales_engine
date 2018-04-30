require 'rails_helper'

describe Merchant do
  it { should validate_presence_of :name }
end
