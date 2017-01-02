class Description < ApplicationRecord
  include Auditable
  include Descriptions::Validation

  belongs_to :script
end
