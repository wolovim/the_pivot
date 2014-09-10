require 'rails_helper'

RSpec.describe Address, :type => :model do

  let(:address) {
    Address.new(item_id: 1, 
                street_1: "123 Washington St", 
                city: "Denver", 
                state: "CO", 
                zip: "80202")
  }

  it 'is valid' do
    expect(address).to be_valid
  end

  it 'is valid with street_2 field' do
    address.street_2 = '#1233'
    expect(address).to be_valid
  end

  it 'is invalid without street_1 field' do
    address.street_1 = nil
    expect(address).to_not be_valid
  end

  it 'is invalid without city field' do
    address.city = nil
    expect(address).to_not be_valid
  end

  it 'is invalid without state field' do
    address.state = nil
    expect(address).to_not be_valid
  end

  it 'is invalid without zip field' do
    address.zip = nil
    expect(address).to_not be_valid
  end

  it "is invalid if it doesn't reference an item" do
    address.item_id = nil
    expect(address).to_not be_valid
  end
end
