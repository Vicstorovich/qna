class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  mount_uploader :image, CourseImageUploader
end
