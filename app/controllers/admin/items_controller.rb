class Admin::ItemsController < AdminController
  before_action :find_item, only: [:edit, :update, :destroy, :show, :order, :remove_category_from_item]

  def index
    @items = Item.all
  end

  def edit
  end

  def show
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

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
