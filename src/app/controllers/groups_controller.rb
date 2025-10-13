class GroupsController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:edit, :new]

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    params.permit(:name)

    Group.update(params[:id], :name => params[:group][:name])

    redirect_to groups_path, notice: "Group #{params[:group][:name]} updated successfully"
  end

  def new
    @group = Group.new
  end

  def create
    params.permit(:name)

    @group = Group.new(:name => params[:group][:name])
    @group.save

    redirect_to groups_path, notice: "Group #{params[:group][:name]} created successfully"
  end
end
