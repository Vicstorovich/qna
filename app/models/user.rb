require 'digest/md5'
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :courses
  has_many :homeworks
  has_many :course_users, dependent: :destroy
  has_many :participated_courses, through: :course_users, class_name: 'Course', source: :course

  accepts_nested_attributes_for :profile, update_only: true

  def not_participate_in_course?(course)
    participated_courses.exists?(course.id)
  end

  def expelled_from_course?(course)
    course_users.find_by(course_id: course.id).pupil if course.course_users.where(user: self).any?
  end

  def author_course?(course)
    id == course.user_id
  end

  def send_reset_password_instructions!
    self.reset_password_token = SecureRandom.hex(12)
    save!

    UsersMailer.reset_password_instructions(self).deliver_now
  end
end
