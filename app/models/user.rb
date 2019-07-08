require "digest/md5"

class User < ApplicationRecord
  SALT = "my_super_cache".freeze

  attr_reader :password

  has_one :profile, dependent: :destroy
  has_many :courses
  has_many :homeworks
  has_many :course_users, dependent: :destroy
  has_many :participated_courses, through: :course_users, class_name: "Course", source: :course

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, confirmation: true
  validates :password, presence: true, unless: -> { encrypted_password.present? }

  accepts_nested_attributes_for :profile, update_only: true

  before_create :build_profile, unless: -> { profile.present? }

  def email=(value)
    value = value.strip if value
    super
  end

  def password=(value)
    self.encrypted_password = password_hash(value)
    @password = value
  end

  def valid_password?(value)
    encrypted_password == password_hash(value)
  end

  def participate_in_course?(course)
    participated_courses.exists?(course.id)
  end

  def author_course?(course)
    id == course.user_id
  end

  private

  def password_hash(value)
    Digest::MD5.hexdigest(value + SALT)
  end
end
