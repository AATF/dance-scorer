module Admin; class SettingsController < ApplicationController
  before_action :get_setting, only: [:edit, :update]

  def edit
  end

  def index
    @settings = Setting.get_all
  end

  def update
    if @setting.value != params[:setting][:value] || @setting.var != params[:setting][:var]
      params.permit!
      @setting.update(params[:setting])
      @setting.save
      redirect_to admin_settings_path, notice: 'Setting has been updated successfully.'
    else
      redirect_to admin_settings_path
    end
  end

  def get_setting
    @setting = Setting.find_by(var: params[:id]) || Setting.new(var: params[:id])
  end
end; end
