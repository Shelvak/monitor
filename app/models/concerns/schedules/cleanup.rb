module Schedules::Cleanup
  extend ActiveSupport::Concern

  def cleanup
    all_destroyed = true

    Schedule.transaction do
      cleanable_runs.find_each do |run|
        destroyed = run.reload.destroy rescue false

        all_destroyed &&= destroyed
      end
    end

    all_destroyed
  end

  private

    def cleanable_runs
      runs.executed.or(runs.canceled).or(runs.aborted).or(runs.overdue)
    end
end
