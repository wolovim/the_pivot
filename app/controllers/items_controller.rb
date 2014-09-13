class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    @main_categories = Category.main_categories
    @special_categories = Category.special_categories
  end

  def show
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :people_per_unit, :bathroom, :user_id)
  end
end
