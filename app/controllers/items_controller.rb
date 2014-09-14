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

  def edit
    @item = current_user.items.find(params[:id])
  end

  def update
    @item = current_user.items.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Listing updated."
      redirect_to listings_user_path(current_user)
    else
      flash[:error] = "Something went wrong. Please try again."
      render :edit
    end
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :people_per_unit, :bathroom, :user_id)
  end
end
