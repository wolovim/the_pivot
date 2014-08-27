class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @order = order
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
