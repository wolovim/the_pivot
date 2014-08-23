class AdminController < ApplicationController
  before_action :authorize?

  def index
  end

  def show
  end

  private
  def authorize?
    redirect_to "https://www.youtube.com/watch?v=4dGOfFbzvq4&t=0m45s" unless current_user.role == "admin"
  end
end
