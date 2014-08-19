class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_order
    return unless session[:order_id]
    @current_order ||= Order.find(session[:order_id])
  end

  def create_order
    return if session[:order_id]
    current_order = Order.create!(delivery: true)
    session[:order_id] = current_order.id
  end
end
