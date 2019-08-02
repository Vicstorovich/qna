class OnlineIntense < Course
  validates :course_start_date, presence: true
  validates :course_end_date, presence: true
  validates :number_hours_practice, presence: true
  validates :number_hours_video, presence: true

  def lesson_available_user?(lesson, user)
    course_start_date < lesson.start_date && course_end_date > lesson.start_date && user_not_participant?(user)
  end
end
