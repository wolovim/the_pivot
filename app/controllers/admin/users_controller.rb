class Admin::UsersController < AdminController
  def show
    @user = User.all
  end

  def destroy
  end
end