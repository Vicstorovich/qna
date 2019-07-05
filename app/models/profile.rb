class Profile < ApplicationRecord
  belongs_to :user

  validates :user, uniqueness: true
  validates :link, url: { schemes: ['https'] }

  mount_uploader :avatar, CourseImageUploader
end
