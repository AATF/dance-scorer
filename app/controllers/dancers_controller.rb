class DancersController < ApplicationController
  before_action :require_login

  def index
    @dancers = Dancer.order(:performance_order)
  end

  def show
    @dancer = Dancer.find(params[:id])
  end

  def edit
    @dancer = Dancer.find(params[:id])
  end
end
