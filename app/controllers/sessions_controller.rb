class SessionsController < ApplicationController
  def new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url, notice: "Logged in!"
  end

  def destroy
    warden.logout
    redirect_to root_url, notice: "Logged out!"
  end

  private
  def log_in_params
    params.permit(:email, :password)
  end
end
