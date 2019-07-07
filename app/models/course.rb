class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :homeworks, through: :lessons, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users

  validates :name, presence: true, length: { minimum: 3 }

  mount_uploader :image, CourseImageUploader
end
