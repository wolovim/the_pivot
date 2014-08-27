class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    @order = order
    @main_categories = Category.main_categories
    @special_categories = Category.special_categories
  end

  def show
    @item = Item.find(params[:id])
    @order = order
  end

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
