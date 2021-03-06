class Script < ApplicationRecord
  include Auditable
  include Attributes::Strip
  include SearchableByName
  include Scripts::Copy
  include Scripts::Descriptions
  include Scripts::Destroy
  include Scripts::Export
  include Scripts::Import
  include Scripts::Injections
  include Scripts::JSON
  include Scripts::Parameters
  include Scripts::Permissions
  include Scripts::Pdf
  include Scripts::Maintainers
  include Scripts::Requires
  include Scripts::Scopes
  include Scripts::Validation
  include Filterable
  include Taggable

  mount_uploader :file, FileUploader

  strip_fields :name

  has_many :jobs, dependent: :destroy
  has_many :runs, through: :jobs
  has_many :issues, through: :runs

  def to_s
    name
  end
end
