class DancersController < ApplicationController
  def index
    @dancers = Dancer.all
  end
end
