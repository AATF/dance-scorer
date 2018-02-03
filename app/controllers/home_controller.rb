class HomeController < ApplicationController
  skip_before_action :current_user

  def index
    p Setting.public_scores
    @groups = Group.all
  end
end
