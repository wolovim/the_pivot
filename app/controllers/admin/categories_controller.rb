class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save

    redirect_to admin_items_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.categorizations.where(category_id: params[:category]).destroy_all

    redirect_to admin_item_path(@item)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
