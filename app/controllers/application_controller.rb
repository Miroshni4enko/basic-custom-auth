class ApplicationController < ActionController::Base
  def current_user
    warden.user
  end
  helper_method :current_user

  def warden
    request.env['warden']
  end
end
