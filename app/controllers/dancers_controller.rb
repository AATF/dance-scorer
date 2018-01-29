class DancersController < ApplicationController
  def index
    @dancers = Dancer.all
  end

  def show
    @dancer = Dancer.find(params[:id])
    @score = Score.find_by(:dancer_id => params[:id])
  end

  def edit
    @dancer = Dancer.find(params[:id])
    @score = Score.find_by(:dancer_id => params[:id])
  end
end
