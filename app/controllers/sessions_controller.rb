class SessionsController < ApplicationController
  def create
    user = User.where(:username => params[:session][:username]).first
    p user
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id

      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
