class Scripts::VersionsController < ApplicationController
  before_action :authorize, :not_guest, :not_security
  before_action :set_title, :set_script
  before_action :set_version, only: [:show]

  def index
    @versions = @script.versions.reorder(created_at: :desc).page params[:page]
  end

  def show
  end

  private

    def set_version
      @version = @script.versions.find params[:id]
    end

    def set_script
      @script = Script.find params[:script_id]
    end
end
