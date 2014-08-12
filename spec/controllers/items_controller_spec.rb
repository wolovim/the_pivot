require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  let(:valid_attributes) { {title: 'food', description: 'yuuuuuum', price: 1.01} }
  describe "GET index" do
    it 'assigns all items as @items' do
      item = Item.create valid_attributes
      get :index
      expect(assigns(:items)).to eq([item])
    end
  end
end
