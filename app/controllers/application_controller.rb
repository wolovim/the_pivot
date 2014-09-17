class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def routing_error
    render "404", :status => 404
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent.signed[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
    session[:user_id] = user.id
    # consolidate orders here, discard the logged-out one
    order.update_attribute(:user_id, user.id)
  end

  helper_method :signed_in?, :current_user, :order

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if user_id # session[:user_id] && cookies.signed[:remember_token]
      @current_user = User.find(user_id)
    end
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    session.clear
  end

  def order
    @order ||= (_session_order || _create_order)
  end

  private

  def user_id
    session[:user_id]
  end

  def _session_order
    return unless session[:order_id]
    @current_order ||= Order.find(session[:order_id])
  end

  def _create_order
    return if session[:order_id]
    current_order = Order.create!
    session[:order_id] = current_order.id
    current_order
  end
end
