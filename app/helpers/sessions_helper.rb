module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent.signed[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
    session[:user_id] = user.id
    order.update_attribute(:user_id, user.id)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= begin
      remember_token = User.digest(cookies.signed[:remember_token])
      User.find_by(remember_token: remember_token)
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
    current_order || create_order
  end

  def current_order
    return unless session[:order_id]
    @current_order ||= Order.find(session[:order_id])
  end

  def create_order
    return if session[:order_id]
    current_order = Order.create!(delivery: true)
    session[:order_id] = current_order.id
    current_order
  end

end
