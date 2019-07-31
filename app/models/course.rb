class Course < ApplicationRecord
  scope :recorded_courses, -> { where(type: 'RecordedCourse') }
  scope :recorded_intenses, -> { where(type: 'RecordedIntense') }
  scope :online_intenses, -> { where(type: 'OnlineIntense') }

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :homeworks, through: :lessons, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users

  validates :name, presence: true, length: { minimum: 3 }

  accepts_nested_attributes_for :lessons
  accepts_nested_attributes_for :course_users, reject_if: :all_blank, allow_destroy: true

  mount_uploader :image, CourseImageUploader

  def user_not_participant?(user)
    course_users.find_by(user_id: user.id).pupil if user.not_participate_in_course?(self)
  end

  def self.types
    %w(OnlineIntense RecordedIntense RecordedCourse)
  end

  def lessons_piority
    lessons.map do |l|
      l.priority
    end
  end

  def homeworks_user(user)
    homeworks.where(user_id: user.id)
  end
end
