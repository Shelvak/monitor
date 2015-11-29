class Users::ImportsController < ApplicationController
  before_action :authorize, :not_guest, :set_title

  # GET /users/import/new
  def new
  end

  # POST /users/import
  def create
    @imports = ldap.import import_params[:username], import_params[:password]
    ids = @imports.map { |i| i[:user].id }.compact

    @deprecated_users = User.where "#{User.table_name}.id NOT IN (?)", ids
  rescue Net::LDAP::Error
    redirect_to new_users_import_url, alert: t('.connection')
  end

  private

    def import_params
      params.require(:import).permit :username, :password
    end
end
