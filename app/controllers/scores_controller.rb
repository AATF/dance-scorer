class ScoresController < ApplicationController
  before_action :require_login

  def index
    @scores = Score.where(:user_id => session[:user_id])
  end

  def update
    params.permit!
    s = Score.find(params[:id].to_i)
    s.update(params[:score].transform_values { |v| v.to_i })

    flash[:notice] = "Successfully updated scores"
    redirect_to dancers_path
  end
end
