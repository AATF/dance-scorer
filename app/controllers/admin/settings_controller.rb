class Admin::SettingsController < ApplicationController
  def edit
    @setting = Setting.find_by_id(params[:id])
  end
end