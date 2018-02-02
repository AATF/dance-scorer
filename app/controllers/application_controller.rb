class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be logged in to access this page"

      redirect_to login_path
    end
  end

  def require_admin
    unless User.find_by_id(session[:user_id]).admin?
      flash[:error] = "You must be an admin to view this page"

      redirect_to root_path
    end
  end
end
