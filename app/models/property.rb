class Property < ActiveRecord::Base
  include Auditable
  include Properties::Validations

  belongs_to :database

  def to_s
    "#{key} -> #{value}"
  end
end