module Users::Filters
  extend ActiveSupport::Concern

  included do
    helper_method :filter_params
  end

  def users
    users = User.search query: params[:q]
    users = users.filter filter_params
    users = users.filter role: params[:role] if params[:role]
    users = users.limit 10                   if request.xhr?

    users
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter).permit :name, :email, :tags
    else
      {}
    end
  end
end
