class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :homeworks, through: :lessons, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users
  has_many :recorded_courses, dependent: :delete_all, as: :additionable
  has_many :recorded_intensifes, dependent: :delete_all, as: :additionable
  has_many :online_intensifes, dependent: :delete_all, as: :additionable

  validates :name, presence: true, length: { minimum: 3 }

  accepts_nested_attributes_for :lessons
  accepts_nested_attributes_for :course_users, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :recorded_courses
  accepts_nested_attributes_for :recorded_intensifes
  accepts_nested_attributes_for :online_intensifes

  mount_uploader :image, CourseImageUploader

  def user_not_participant?(user)
    course_users.find_by(user_id: user.id).pupil if user.not_participate_in_course?(self)
  end
end
