class ScoresController < ApplicationController
  def index
    @scores = Score.all
  end

  def update
    params.permit!
    s = Score.find(params[:id].to_i)
    s.update(params[:score].transform_values { |v| v.to_i })
  end
end
