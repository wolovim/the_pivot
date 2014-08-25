class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def completed
    @orders = Order.completed
  end

  def basket
    @orders = Order.basket
  end

  def paid
    @orders = Order.paid
  end

  def ordered
    @orders = Order.ordered
  end

  def cancelled
    @orders = Order.cancelled
  end
end
