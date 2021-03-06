module Servers::Scopes
  extend ActiveSupport::Concern

  module ClassMethods
    def by_name name
      where "#{table_name}.name ILIKE ?", "%#{name}%"
    end

    def by_hostname hostname
      where "#{table_name}.hostname ILIKE ?", "%#{hostname}%"
    end

    def by_user user
      where "#{table_name}.user ILIKE ?", "%#{user}%"
    end
  end
end
