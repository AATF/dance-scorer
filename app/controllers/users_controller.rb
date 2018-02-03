class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: :edit

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by_id(params[:id])
  end
end
