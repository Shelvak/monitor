module Runs::Scopes
  extend ActiveSupport::Concern

  module ClassMethods
    def by_status status
      where status: status
    end

    def by_scheduled_at range_as_string
      dates = range_as_string.split(/\s*-\s*/).map do |d|
        Timeliness.parse d rescue nil
      end
      start  = dates.first
      finish = dates.last

      start && finish ? where(scheduled_at: start..finish) : all
    end
  end
end