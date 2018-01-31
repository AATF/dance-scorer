class DancersController < ApplicationController
  before_action :require_login

  def index
    @dancers = Dancer.all
  end

  def show
    @dancer = Dancer.find(params[:id])
    @score = Score.find_by(:dancer_id => params[:id])
  end

  def edit
    @dancer = Dancer.find(params[:id])
    @score = Score.find_by(:dancer_id => params[:id], :user_id => session[:user_id])
  end
end
