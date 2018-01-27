class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "User created"
    else
      flash[:alert] = "User could not be created"
    end
  end

  def destroy
    user = User.find_by params[:id]
    user.destroy
    flash[:notice] = "User deleted"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
