class SettingController < ApplicationController
  def update
    Setting.push(params[:setting].to_sym, params[:text])
    Setting.pull(params[:setting].to_sym, true)
    redirect_to setting_path
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def show
    @setting = Setting.find(params[:id])
    @versions = @setting.versions
  end

  def index
    @settings = Setting.pull_all
  end
end
