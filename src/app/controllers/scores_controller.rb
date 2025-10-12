class ScoresController < ApplicationController
  before_action :require_login

  def new
  end

  def index
    @scores = if session[:admin]
                Score.all
              else
                Score.where(user_id: session[:user_id])
              end
  end

  def edit
    @dancer = Dancer.find(params[:id])
    if session[:admin]
      @score = Score.find_by(dancer_id: @dancer.id, user_id: params[:user_id])
    else
      score = Score.find_by(dancer_id: @dancer.id, user_id: session[:user_id])
      if score
        @score = score
      else
        redirect_to new_score_path
      end
    end
  end

  def update
    params.permit(params[:score][:total])

    if params[:score][:total]
      scores = scores = params[:score].transform_values { |v| -1 }
      total = params[:score][:total]
    else
      scores = params[:score].transform_values { |v| v.to_f }
      total = ScoresHelper.total_score(scores)
    end
    scores[:total] = total

    s = Score.find(params[:id].to_i)
    s.update!(scores)

    flash[:notice] = "Successfully updated scores"
    redirect_to scores_path
  end
end
