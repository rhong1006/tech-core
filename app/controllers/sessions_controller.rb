class SessionsController < ApplicationController

  def new
  end

  def create
    # TODO change alert message and Don't show it by default.
    # The current actions shows this message when the user signs in. 
    flash[:alert] = 'entrou aqui'
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Thank you for sign in!'
      redirect_to home_path
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
