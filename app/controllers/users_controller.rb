class UsersController < ApplicationController
  before_action :require_login, :require_admin

  def index
    @users = User.all
  end

  def edit
  end
end
