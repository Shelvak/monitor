class SchedulesController < ApplicationController
  before_action :authorize, :not_guest
  before_action :set_title, except: [:destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy, :run]

  respond_to :html, :json

  def index
    @schedules = Schedule.search(query: params[:q], limit: request.xhr? && 10).page params[:page]

    respond_with @schedules
  end

  def show
    respond_with @schedule
  end

  def new
    @schedule = Schedule.new

    respond_with @schedule
  end

  def edit
  end

  def create
    @schedule = Schedule.new schedule_params

    @schedule.save
    respond_with @schedule
  end

  def update
    @schedule.update schedule_params
    respond_with @schedule
  end

  def destroy
    @schedule.destroy
    respond_with @schedule
  end

  def run
    @schedule.run

    respond_with @schedule, location: schedule_runs_url(@schedule)
  end

  private
    def set_schedule
      @schedule = Schedule.find params[:id]
    end

    def schedule_params
      params.require(:schedule).permit :name, :start, :end, :interval, :frequency, :lock_version,
        jobs_attributes: [:id, :server_id, :script_id, :_destroy],
        taggings_attributes: [:id, :tag_id, :_destroy],
        dependencies_attributes: [:id, :schedule_id, :_destroy],
        dispatchers_attributes: [:id, :rule_id, :_destroy]
    end
end
