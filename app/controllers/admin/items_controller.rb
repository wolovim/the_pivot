class Admin::ItemsController < AdminController
  before_action :find_item, only: [:edit, :update, :destroy, :show]

  def index
    @items = Item.all
  end

  def edit
  end

  def show
    @categories = Category.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def update
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end

  def destroy
    @item.destroy
    redirect_to admin_items_path
  end

  def add_category
    @item = Item.find(params[:id])
    @category = Category.find(params[:category])
    @item.add_category(@category)

    redirect_to admin_item_path(@item)
  end

  def remove_category
    @item = Item.find(params[:id])
    @category = Category.find(params[:category])
    @item.remove_category(@category)

    redirect_to admin_item_path(@item)
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def extinction
    item = Item.find(params[:id])
    Item.extinction(item)
    redirect_to admin_item_path(item)
  end
end
