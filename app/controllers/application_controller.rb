class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end
end
