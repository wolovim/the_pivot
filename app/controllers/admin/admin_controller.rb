class Admin::AdminController < ApplicationController
  before_action :authorize?

  def index
  end

  def show
  end

  private
  def authorize?
    redirect_to "https://www.youtube.com/watch?v=RfiQYRn7fBg" unless current_user.role == "admin"
  end
end
