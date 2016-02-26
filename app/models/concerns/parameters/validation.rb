module Parameters::Validation
  extend ActiveSupport::Concern

  included do
    validates :name, :value, presence: true, length: { maximum: 255 }
  end
end
