class Admin::UsersController < ApplicationController
  before_action :is_admin!
  before_action :set_user, only: [:update]

  def index
    @user = User.new
    @users = User.order(:first_name)
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to admin_users_path
      flash[:notice] = "User created"
    else
      redirect_to admin_users_path
      flash[:alert] = "User could not be created"
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User changed successfully!'
      redirect_to admin_users_path
    end
  end

  def destroy
    user = User.find params[:id]
    puts params[:user_id]
    puts user.first_name
    user.destroy!
    puts 'after'
    flash[:notice] = "User deleted"
    redirect_to admin_users_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :is_admin)
  end

end
