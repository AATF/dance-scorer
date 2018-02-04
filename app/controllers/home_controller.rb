class HomeController < ApplicationController
  def index
    p Setting.public_scores
    @groups = Group.all
  end
end
