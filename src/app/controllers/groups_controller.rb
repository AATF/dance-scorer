class GroupsController < ApplicationController
  before_action :require_login

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    params.permit(params[:id], params[:group])

    Group.update(params[:id], params[:group])

    redirect_to groups_path, notice: "Group #{params[:group][:name]} updated successfully"
  end
end
