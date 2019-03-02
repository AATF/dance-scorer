module Admin; class SettingsController < ApplicationController
  include RailsSettings::Extend

  def edit
    @setting = Setting.find_by_id(params[:id])
  end

  def update
    params.permit!
    Setting.update(params[:setting])

    redirect_to admin_settings_path
  end

  def index
    @settings = Setting.all
  end

  def new
    @setting = Setting.new(params[:setting])
  end
end; end
