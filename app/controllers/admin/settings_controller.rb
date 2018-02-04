class Admin; class SettingsController < ApplicationController
  def edit
    @setting = Setting.find_by_id(params[:id])
  end

  def update
    Setting.update(var: params[:id], value: params[:setting][:value])
  end

  def index
    @settings = Setting.all
  end

   def new
     @setting = Setting.new(params[:setting])
   end
end; end