class OrdersController < ApplicationController
  include OrdersHelper

  def index
    @orders = Order.all
  end

  def show
    @order = order
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

  def delete_item
    item = Item.find(params[:item_id])
    current_order.remove_item(item)
    redirect_to current_order
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.save
      redirect_to checkout_path
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

  def checkout
    @order = order
    @address = Address.find_by(order_id: @order.id) || Address.new
  end

  def confirm
    @order = order
    if @order.basket?
      @order.ordered!
    end

    @address = Address.find_by(order_id: @order)
  end

  def paid
    @order = order
    if @order.ordered?
      @order.paid!
    end

  end


end
