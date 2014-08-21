class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save

    redirect_to admin_items_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
