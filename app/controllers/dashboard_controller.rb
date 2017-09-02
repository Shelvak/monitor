class DashboardController < ApplicationController
  include Issues::Filters

  before_action :authorize
  before_action :set_title

  helper_method :filter_params
  helper_method :issue_filter

  respond_to :html

  def index
    @script_counts = Kaminari.paginate_array(issue_count_by_script.to_a).page params[:page]

    respond_with @script_counts
  end

  private

    def filter_params
      params[:filter].present? ?
        params.require(:filter).permit(:name, :status, :show, :tags, :user_id, :user, :description) :
        {}
    end

    def issue_filter
      filter_params.slice :status, :tags, :description, :user_id
    end

    def issues
      if issue_filter[:status].present?
        scoped_issues.filter(issue_filter)
      else
        scoped_issues.filter(issue_filter).active
      end
    end

    def issue_count_by_script
      issues.grouped_by_script.ordered_by_script_name.count
    end

    def scoped_issues
      issues = show_mine? ? current_user.issues : Issue.all
      issues = issues.by_script_name filter_params[:name] if filter_params[:name].present?

      issues
    end
end
