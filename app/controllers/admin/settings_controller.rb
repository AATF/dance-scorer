class Admin; class SettingsController < ApplicationController
  def edit
    @setting = Admin::Setting.find_by_id(params[:id])
  end

  def update
    params.permit!
    Admin::Setting.update(params[:setting])

    redirect_to admin_settings_path
  end

  def index
    @settings = Admin::Setting.all
  end

   def new
     @setting = Admin::Setting.new(params[:setting])
   end
end; end
