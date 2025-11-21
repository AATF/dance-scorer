class DancersController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:edit, :new]

  def index
    @dancers = Dancer.order(:group).order(:performance_order).group_by(:group)
  end

  def show
    @dancer = Dancer.find(params[:id])
  end

  def edit
    @dancer = Dancer.find(params[:id])
    @groups = Group.all
  end

  def update
    params.permit(:name, :performance_order, :group_id, :dance_name)

    dancer = params[:dancer]
    @dancer = Dancer.update(params[:id], :name => dancer[:name], :performance_order => dancer[:performance_order], :group_id => dancer[:group_id], :dance_name => dancer[:dance_name])

    redirect_to dancer_path, notice: "Dancer has been updated."
  end

  def new
    @dancer = Dancer.new
    @groups = Group.all
  end

  def create
    params.permit(:name, :dance_name, :performance_order)

    dancer = params[:dancer]

    @dancer = Dancer.new(:name => dancer[:name], :dance_name => dancer[:dance_name], :performance_order => dancer[:performance_order], :group_id => dancer[:group_id])
    @dancer.save

    redirect_to dancers_path, notice: "Dancer #{dancer[:name]} has been created"
  end

end
