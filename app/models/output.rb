class Output < ApplicationRecord
  include Auditable
  include Outputs::Scopes
  include Outputs::Validation

  belongs_to :trigger
  belongs_to :run
  has_one :rule, through: :trigger
end
