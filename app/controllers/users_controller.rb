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
      log_user_in(@user)
      redirect_to @user, notice: 'Welcome to Endangered Eats'
    else
      flash[:invalid] = @user.errors.messages
      render :new
    end
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password,
                                  :password_confirmation)
  end
end
