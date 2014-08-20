class UsersController < ApplicationController
  def index
  @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!

    respond_to do |format|
      format.html { redirect_to @user, notice: 'Welcome to Endangered Eats' }
      format.json { render :show, status: :created, location: @user }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password,
                                  :password_confirmation)
  end
end
