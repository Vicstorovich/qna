class Course < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  mount_uploader :image, CourseImageUploader
end
