class SessionsController < ApplicationController
  def create
    user = User.find_by_email(log_in_params[:email])
    if user && user.authenticate(log_in_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or pass"
      render "new"
    end
  end

  def new
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

  private
  def log_in_params
    params.permit(:email, :password)
  end
end
