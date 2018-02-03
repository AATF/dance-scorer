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
    if session[:admin]
      @score = Score.find_by(:dancer_id => @dancer.id)
    else
      score = Score.find_by(:dancer_id => @dancer.id, :user_id => session[:user_id])
      if score
        @score = score
      else
        redirect_to new_score_path
      end
    end
  end
end
