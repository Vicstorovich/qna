class RecordedCourse < Course
  validates :number_hours_video, presence: true

  def lesson_available?(_lesson, user)
    user_not_participant?(user)
  end
end
