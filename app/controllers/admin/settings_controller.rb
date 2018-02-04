class Admin::SettingsController < ApplicationController
  def edit
    @setting = Setting.find_by_id(params[:id])
  end

  def update
    Setting.update(var: params[:id], value: params[:setting][:value])
  end
end