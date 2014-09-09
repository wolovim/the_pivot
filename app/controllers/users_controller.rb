class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to TravelHome!'
      redirect_to @user
    else
      render :new
    end
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name,
                                   :username,   :email,
                                   :password,   :password_confirmation)
  end
end
