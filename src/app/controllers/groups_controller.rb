class GroupsController < ApplicationController
  before_action :require_login

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    params.permit(:id, :group)

    Group.update(params[:id], params[:group])

    redirect_to groups_path, notice: "Group #{params[:group][:name]} updated successfully"
  end

  def new
    @group = Group.new
  end

  def create
    #params.permit(:id, :name)
    params.permit!

    @group = Group.new(:name => params[:group][:name])
    @group.save

    redirect_to groups_path, notice: "Group #{params[:group][:name]} created successfully"
  end
end
