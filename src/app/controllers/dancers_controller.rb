class DancersController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:edit, :new]

  def index
    @dancers = Dancer.order(:performance_order)
  end

  def show
    @dancer = Dancer.find(params[:id])
  end

  def edit
    @dancer = Dancer.find(params[:id])
  end

  def update
    params.permit(:id, :dancer)

    @dancer = Dancer.update(params[:id], params[:dancer])

    redirect_to dancer_path, notice: "Dancer has been updated."
  end

  def new
    @dancer = Dancer.new
  end

  def create
    params.permit!
#    params.require(:dancer)

    dancer = params[:dancer]

    @dancer = Dancer.new(:name => dancer[:name], :dance_name => dancer[:dance_name], :performance_order => dancer[:performance_order])
    @dancer = Dancer.new(:name => dancer[:name])
    @dancer.save

    redirect_to dancers_path, notice: "Dancer #{dancer[:name]} has been created"
  end

end
