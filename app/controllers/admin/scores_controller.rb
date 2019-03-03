module Admin; class ScoresController < ApplicationController
  def edit
    @dancer = Dancer.find(params[:id])
  end

  def index
  end

  def update
  end
end; end
