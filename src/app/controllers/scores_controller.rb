class ScoresController < ApplicationController
  before_action :require_login

  def new
    @dancer = Dancer.find_by_id(params[:dancer_id])
    @score = Score.new
  end

  def index
    @scores = if session[:admin]
                Score.all
              else
                Score.where(user_id: session[:user_id])
              end
  end

  def create
    params.permit(:dancer_id, :user_id, :theme, :presentation, :technique, :choreography, :costume, :music, :violation, :total)

    dancer_id = params[:dancer_id]
    score = params[:score]

    @score = Score.new(dancer_id: dancer_id, user_id: session[:user_id], theme: score[:theme], presentation: score[:presentation], technique: score[:technique], choreography: score[:choreography], costume: score[:costume], music: score[:music], violation: score[:violation], total: total_score(score))
    if @score.save
      redirect_to dancer_path(id: dancer_id), notice: "Score created successfully"
    else
      errors = @score.errors.map { |k| k.full_message }.join(", ")

      redirect_to dancer_path(id: dancer_id), warning: errors
      flash[:warning] = errors
    end
  end

  def edit
    @dancer = Dancer.find_by_id(params[:id])
    if session[:admin]
      @score = Score.find_by(dancer_id: @dancer.id, user_id: params[:user_id])
    else
      score = Score.find_by(dancer_id: @dancer.id, user_id: session[:user_id])
      if score
        @score = score
      else
        redirect_to new_score_path(dancer_id: @dancer.id)
      end
    end
  end

  def update
    params.permit(:dancer_id, :user_id, :theme, :presentation, :technique, :choreography, :costume, :music, :violation, :total)

    score = params[:score]
    score[:total] = total_score(score)

    s = Score.find(params[:id].to_i)
    s.update(dancer_id: score[:dancer_id], user_id: session[:user_id], theme: score[:theme], presentation: score[:presentation], technique: score[:technique], choreography: score[:choreography], costume: score[:costume], music: score[:music], violation: score[:violation], total: total_score(score))
    if s.save
      flash[:notice] = "Successfully updated scores"
      redirect_to scores_path
    else
      errors = s.errors.map { |k| k.full_message }.join(", ")

      flash[:warning] = errors
      redirect_to scores_path, warning: errors
    end
  end

  private

  def total_score(score)
    if score[:total]
      scores = score.transform_values { |v| ScoresHelper::NIL_SCORE }
      total = score[:total]
    else
      scores = score.transform_values { |v| v.to_f }
      total = ScoresHelper.total_score(scores)
    end
  end
end
