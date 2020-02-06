class Profile < ApplicationRecord
  VALID_EMAIL_GITHAB = %r{^https://github\.com/}i.freeze

  belongs_to :user

  validates :user, uniqueness: true
  validates :name, presence: true

  mount_uploader :avatar, CourseImageUploader
end
