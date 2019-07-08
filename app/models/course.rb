class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :homeworks, through: :lessons, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users

  validates :name, presence: true, length: { minimum: 3 }

  accepts_nested_attributes_for :course_users, reject_if: :all_blank, allow_destroy: true

  mount_uploader :image, CourseImageUploader

  def user_participant?(user, course)
    course_users.find_by(user_id: user.id).ban if user.participate_in_course?(course)
  end
end
