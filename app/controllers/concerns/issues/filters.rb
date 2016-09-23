module Issues::Filters
  extend ActiveSupport::Concern

  included do
    helper_method :filter_params
  end

  def issues
    scoped_issues.filter filter_params.except(:show)
  end

  def issue_params
    args = @issue.can_be_edited_by?(current_user) ? editors_params : guest_params

    params.require(:issue).permit(*args)
  end

  def filter_params
    if params[:filter].present?
      params.require(:filter).permit :id, :description, :status, :show, :tags, :data, :created_at
    else
      {}
    end
  end

  def filter_default_status?
    filter_params[:status].present?
  end

  def show_mine?
    current_user.guest? || current_user.security? ||
      (action_name == 'index' && filter_params[:show] != 'all')
  end

  private

    def scoped_issues
      if @permalink
        @permalink.issues
      elsif @script
        _issues.script_scoped(@script)
      else
        _issues
      end
    end

    def _issues
      show_mine? ? current_user.issues : Issue.all
    end

    def editors_params
      [
        :status, :description,
          subscriptions_attributes: [:id, :user_id, :_destroy],
          comments_attributes: [:id, :text, :file, :file_cache],
          taggings_attributes: [:id, :tag_id, :_destroy]
      ]
    end

    def guest_params
      [
        comments_attributes: [:id, :text, :file, :file_cache]
      ]
    end
end
