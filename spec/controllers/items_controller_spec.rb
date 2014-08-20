require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  let(:valid_attributes) { {title: 'food', description: 'yuuuuuum', price: 1} }
  describe "GET index" do
    it 'assigns all items as @items' do
      item = Item.create valid_attributes
      get :index
      expect(assigns(:items)).to eq([item])
    end
  end

  describe "GET new" do
    it 'assigns a new person as @person' do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      item = Item.create valid_attributes
      get :edit, {id: item.to_param}

      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST create" do
    describe "with valid attributes" do
      it "creates a new item" do
        expect{
          post :create, {:item => valid_attributes}
        }.to change(Item, :count).by(1)
      end

      it 'assigns new item as @item' do
        post :create, {:item => valid_attributes}
        expect(assigns(:item)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        Item.any_instance.stub(:save).and_return(false)
        post :create, {:item => {title: 'invalid'}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid attributes" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        put :update, {:id => item.to_param, :item => valid_attributes}
        expect(item).to eq(assigns(:item))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}
      }.to change(Item, :count).by(-1)
    end
  end

end
