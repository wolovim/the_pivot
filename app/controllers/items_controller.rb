class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    @order = order
  end

  def show
    @item = Item.find(params[:id])
    @order = order
  end

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
