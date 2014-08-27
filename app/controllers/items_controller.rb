class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    @order = current_order || create_order
  end

  def show
    @item = Item.find(params[:id])
    @order = current_order || create_order
  end

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
