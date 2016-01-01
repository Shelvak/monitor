class ApplicationController < ActionController::Base
  include ActionTitle
  include CurrentUser
  include LdapConfig
  include Roles
  include UpdateResource

  protect_from_forgery with: :exception

  def authorize
    redirect_to login_url, alert: t('messages.not_authorized') unless current_user
  end

  def user_for_paper_trail
    current_user&.id
  end
end
