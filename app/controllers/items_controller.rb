class ItemsController < ApplicationController
  def index
    @items = Item.all
    # @categories = Category.all
    # @main_categories = Category.main_categories
    # @special_categories = Category.special_categories
    respond_to do |format|
      format.html
      format.json{
        # data = @items.collect do |item|
        #   item.as_json.merge(
        #     {'path' => item_path(item),
        #      'accommodation' => item.accommodation}
        #   )
        # end
        # render json: data.to_json

        render json: @items, root: false

      }
    end
  end

  def show
    @item = Item.find(params[:id])
    @order = _session_order
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      flash[:success] = "Listing created!"

      create_availabilities

      redirect_to new_item_image_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def update
    @item = current_user.items.find(params[:id])
    @item.item_images.build

    if @item.update(item_params)
      flash[:success] = "Listing updated."
      
      create_availabilities

      redirect_to new_item_image_path(@item)
    else
      flash[:error] = "Something went wrong. Please try again."
      render :edit
    end
  end

  def create_availabilities
    dates = @item.parse_available_dates(params[:from], params[:to])

    @item.availabilities.create(dates) if dates
  end

  def item_params
    params.require(:item).permit(:title, :description, :price,
                                 :people_per_unit, :bathroom, 
                                 :user_id, :item_image_attributes)
  end
end
