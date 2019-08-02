class RecordedIntense < Course
  validates :number_hours_practice, presence: true
  validates :number_hours_video, presence: true

  def lesson_one?(lesson)
    lessons_piority.first == lesson.priority
  end

  def another_lesson?(lesson, user)
    unless homeworks_user(user).last.nil?
      lesson.priority == Lesson.another_lesson(homeworks_user(user).last.lesson_id)
    end
  end

  def lesson_available_user?(lesson, user)
    lesson_one?(lesson) || another_lesson?(lesson, user) || lesson.homeworks.exists?
  end
end
