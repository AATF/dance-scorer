class HomeController < ApplicationController
  skip_before_action :current_user

  def index
    @scores = Score.all
  end
end
