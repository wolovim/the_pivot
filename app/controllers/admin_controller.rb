class AdminController < ApplicationController
  before_action :authorize?

  def index
  end

  def show
  end

  private
  def authorize?
    session[:user_id] == current_user.id
  end
end
