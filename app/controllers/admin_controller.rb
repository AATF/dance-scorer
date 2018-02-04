class AdminController < ApplicationController
  def index
    @settings = Setting.all
  end
end
