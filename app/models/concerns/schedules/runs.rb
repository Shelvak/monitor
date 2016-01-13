module Schedules::Runs
  extend ActiveSupport::Concern

  included do
    before_save :remove_pending_runs, if: :remove_pending_runs?
    before_save :set_scheduled_at,    if: :start_changed?
    before_save :create_initial_runs, if: :schedule_changed?

    has_many :runs, -> { order :scheduled_at }, through: :jobs
  end

  def build_next_runs
    scheduled_at = next_date

    if self.end.blank? || scheduled_at <= self.end
      jobs.map do |job|
        job.runs.pending.create! scheduled_at: scheduled_at
      end
    end
  end

  def run
    scheduled_at = Time.zone.now

    jobs.each do |job|
      run = job.runs.create! status: 'scheduled', scheduled_at: scheduled_at

      ScriptJob.perform_later run
    end
  end

  def run?
    required.all? &:last_run_ok?
  end

  def last_run_ok?
    runs.executed.last.try :ok?
  end

  def next_date
    interval = self.interval || 1

    start.advance frequency.to_sym => (intervals_since_start + 1) * interval
  end

  private

    def set_scheduled_at
      self.scheduled_at = start
    end

    def schedule_changed?
      start_changed? || interval_changed? || frequency_changed?
    end

    def create_initial_runs
      self.scheduled_at = start.past? ? next_date : start

      jobs.each do |job|
        job.runs.pending.build scheduled_at: scheduled_at
      end
    end

    def remove_pending_runs?
      persisted? && schedule_changed?
    end

    def remove_pending_runs
      runs.pending.destroy_all
    end

    def intervals_since_start
      now      = Time.zone.now
      interval = self.interval || 1

      if frequency == 'months'
        result = (now.year * 12 + now.month) - (start.year * 12 + start.month)
      else
        distance_in_minutes = ((now - start) / 60.0).truncate
        factors = {
          minutes: 1,
          hours:   60,
          days:    60 * 24,
          weeks:   60 * 24 * 7
        }

        result = (distance_in_minutes / factors[frequency.to_sym]).truncate
      end

      result > 0 ? (result / interval) : 0
    end
end
