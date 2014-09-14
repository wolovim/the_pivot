class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "User profile updated!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Something went wrong! Please try again."
      render :edit
    end
  end

  def listings
    @user = User.find(params[:id])
    @items = @user.items.all.to_a
  end

  def dashboard
    return render "errors/404" unless current_user
    @user = current_user

    render "errors/404"  unless session[:user_id] == current_user.id
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name,
                                   :username,   :email,
                                   :city,       :state,
                                   :password,   :password_confirmation)
  end
end
