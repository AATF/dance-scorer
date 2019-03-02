class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: :edit

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    params.permit!
    params[:user][:id] = params[:id]

    User.update(params[:id], params[:user])

    redirect_to users_path, notice: "User updated successfully"
  end
end
