class SessionsController < ApplicationController
  skip_before_action :current_user

  def new
    if session[:logged_in]
      flash[:notice] = "You are already logged in"

      redirect_to root_path
    end
  end

  def create
    user = User.where(username: params[:session][:username]).first
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:logged_in] = true
      if user.admin?
        session[:admin] = true
      end

      redirect_to root_path
    else
      flash[:warning] = "Incorrect username and/or password"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
