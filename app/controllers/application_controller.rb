class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def require_login
    unless session[:user_id]
      flash[:warning] = "You must be logged in to access this page"

      redirect_to login_path
    end
  end

  def require_admin
    unless @current_user.admin?
      flash[:warning] = "You must be an admin to view this page"

      redirect_to root_path
    end
  end
end
