class ScoresController < ApplicationController
  def index
    @scores = Score.all
  end
end
