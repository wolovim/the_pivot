require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:valid_params) { {name: 'category'} }

  it 'is valid' do
    category = build_category valid_params
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = build_category name: nil
    expect(category).to_not be_valid
  end

  it 'has an array of items' do
    category = build_category valid_params
    expect(category.items).to eq([])
  end

  def build_category(options)
    Category.new options
  end
end
