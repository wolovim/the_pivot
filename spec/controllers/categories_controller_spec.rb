require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe "GET show" do
    it 'assigns the requested category as @category' do
      category = Category.create(name:'africa')
      get :show, {id: category.to_param}
      expect(assigns(:category)).to eq (category) 
    end
  end
end
