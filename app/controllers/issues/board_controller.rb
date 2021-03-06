class Issues::BoardController < ApplicationController
  include Issues::Filters

  before_action :authorize, :not_guest
  before_action :only_supervisor, only: [:destroy_all]
  before_action :set_title
  before_action :set_issue,  only: [:create, :destroy]
  before_action :set_script, only: [:create, :destroy]

  respond_to :html, :js, :pdf

  def index
    @issues = issues.order(:created_at).where id: board_session
    @issues = @issues.page params[:page] unless request.format == :pdf

    respond_with @issues
  end

  def create
    @issues = filter_default_status? || @issue ? issues : issues.active

    board_session.concat(@issues.pluck('id')).uniq!

    redirect_back(fallback_location: root_url) unless request.xhr?
  end

  def update
    _issues = issues.where id: board_session

    update_issues _issues

    if board_session_errors.empty?
      redirect_to issues_board_url, notice: t('.updated')
    else
      redirect_to issues_board_url, alert: t('.fail')
    end
  end

  def destroy
    @issues = filter_default_status? || @issue ? issues : issues.active

    @issues.each { |issue| board_session.delete issue.id }

    redirect_back fallback_location: root_url unless request.xhr?
  end

  def empty
    board_session.clear
    board_session_errors.clear

    redirect_to dashboard_url, notice: t('.done')
  end

  def destroy_all
    issues.where(id: board_session).destroy_all

    board_session.clear
    board_session_errors.clear

    redirect_to dashboard_url, notice: t('.destroyed')
  end

  private

    def set_issue
      @issue = issues.find filter_params[:id] if filter_params[:id]
    end

    def set_script
      @script = Script.find params[:script_id] if params[:script_id]
    end

    def issue_params
      permit = [
        :status,
        comments_attributes:      [:text, :file],
        taggings_attributes:      [:tag_id],
        subscriptions_attributes: [:user_id]
      ]

      permit = [:description] + permit if current_user.supervisor?

      params.require(:issue).permit *permit
    end

    def board_session
      session[:board_issues] ||= []
    end

    def board_session_errors
      session[:board_issue_errors] ||= {}
    end

    def update_issues issues
      present_issue_params = issue_params.select { |_, value| value.present? }
      taggings_attributes  = present_issue_params.fetch(:taggings_attributes, {})
      new_tags             = taggings_attributes.select do |index, tagging|
        tagging[:tag_id].present?
      end

      board_session_errors.clear

      issues.find_each do |issue|
        update_issue issue, present_issue_params, new_tags.present?
      end
    end

    def update_issue issue, issue_params, remove_previous_tags
      Issue.transaction do
        issue.taggings.clear if remove_previous_tags

        unless issue.update issue_params
          board_session_errors[issue.id] = issue.errors.full_messages

          raise ActiveRecord::Rollback
        end
      end
    end
end
