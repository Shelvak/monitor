class User < ApplicationRecord
  include Auditable
  include Filterable
  include Taggable
  include Attributes::Strip
  include Attributes::Downcase
  include Users::Authentication
  include Users::Destroy
  include Users::Overrides
  include Users::PasswordReset
  include Users::Roles
  include Users::Scopes
  include Users::Search
  include Users::Validation

  strip_fields :name, :lastname, :email, :username
  downcase_fields :email, :username

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :issues, through: :subscriptions
end
