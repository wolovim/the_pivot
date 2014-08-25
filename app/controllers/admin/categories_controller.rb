class Admin::CategoriesController < AdminController
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
    @category = Category.find(params[:category])
    @item.remove_category(@category)
     
    redirect_to admin_item_path(@item)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
