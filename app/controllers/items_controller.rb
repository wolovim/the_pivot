class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update, :destroy, :show, :order]

  def index
    @items = Item.all
    @categories = Category.all
    @order = current_order || create_order
  end

  def show
    @order = current_order || create_order
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def update
    if @item.save
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
