class Course < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 3 }

  mount_uploader :image, CourseImageUploader
end
