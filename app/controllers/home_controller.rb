class HomeController < ApplicationController
  def index
    @scores = Score.all
  end
end
