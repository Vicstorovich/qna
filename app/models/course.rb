class Course < ApplicationRecord
  scope :recorded_courses, -> { where(type: 'RecordedCourse') }
  scope :recorded_intenses, -> { where(type: 'RecordedIntense') }
  scope :online_intenses, -> { where(type: 'OnlineIntense') }

  scope :with_course_participant_flag, -> (user) { joins(%Q{LEFT OUTER JOIN "course_users" ON "course_users"."course_id" = "courses"."id" AND "course_users"."user_id" = #{user}}).select('courses.id, courses.name, courses.type, course_users.pupil').group('courses.id', 'course_users.id')}

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
    user.not_participate_in_course?(self) ? course_users.find_by(user_id: user.id).pupil : false
  end

  def self.types
    %w[OnlineIntense RecordedIntense RecordedCourse]
  end

  def lessons_piority
    lessons.map(&:priority)
  end

  def homeworks_user(user)
    homeworks.where(user_id: user.id)
  end

  def lesson_available_user?(_lesson, user)
    user_not_participant?(user)
  end
end
