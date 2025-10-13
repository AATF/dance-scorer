module Admin; class SettingsController < ApplicationController
  before_action :get_setting, only: [:edit, :update]

  def edit
  end

  def index
    @settings = Setting.keys
  end

  def update
    setting = params[:setting]

    if @setting.value != setting[:value] || @setting.var != setting[:var]
      params.permit(:var, :value)

      @setting.update(:var => setting[:var], :value => setting[:value])
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
