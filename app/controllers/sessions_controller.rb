class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Thank you for sign in!'
      if current_user.is_admin?
        redirect_to admin_organizations_path
      else
        redirect_to organizations_path
      end
    else
      flash.now[:alert] = 'Wrong email or password!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Signed Out!'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
