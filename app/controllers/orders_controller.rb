class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    current_order
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def add_item
    item = Item.find(params[:item_id])
    current_order.add_item(item)
    redirect_to current_order
  end

  def create
    # order_params needs to be filled out
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def update
    if @order.save
      redirect_to @order
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit()
  end

  def find_orders
    @order = Order.find(params[:id])
  end
end
