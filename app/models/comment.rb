class Comment < ActiveRecord::Base
  include Auditable
  include Comments::Notify
  include Comments::Validation

  belongs_to :user
  belongs_to :issue
  has_many :users, through: :issue

  def to_s
    text
  end
end