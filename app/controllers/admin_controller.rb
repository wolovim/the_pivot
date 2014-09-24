class AdminController < ApplicationController
  before_action :authorize?

  def index
  end

  def show
  end

  private
  def authorize?
    render 'errors/404' unless current_user.role == "admin"
  end
end
