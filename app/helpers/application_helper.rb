module ApplicationHelper

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def logged_in?

  end

  def log_user_in(user)
    session[:user_id] = user.id
  end
end
