class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
    @main_categories = Category.main_categories
    @special_categories = Category.special_categories
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

      if params[:from] != "" && params[:to] != ""
        dates = parse_available_dates(params[:from], params[:to])
        @item.availabilities.create(dates)
      end
      
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def update
    @item = current_user.items.find(params[:id])
    dates = parse_available_dates(params[:from], params[:to])
    @item.availabilities.create(dates)
    
    if @item.update(item_params)
      flash[:success] = "Listing updated."
      redirect_to listings_user_path(current_user)
    else
      flash[:error] = "Something went wrong. Please try again."
      render :edit
    end
  end

  private

  def parse_available_dates(start_date, end_date)
    start_date = Date.strptime(start_date, "%m/%d/%Y")
    end_date = Date.strptime(end_date, "%m/%d/%Y")
    date_range = (start_date..end_date).to_a

    date_range.map { |date| {date: date} }
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :people_per_unit, :bathroom, :user_id)
  end
end
