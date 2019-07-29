module LessonsHelper
  def view_homework_user_this_lesson(lesson)
    if current_user.homeworks.select_lesson(lesson.id).present?
      current_user.homeworks.select_lesson(lesson.id).last.body
    end
  end

  def lesson_one?(course, lesson)
    course.lessons_piority.first == lesson.priority
  end

  def another_lesson?(course, lesson, user)
    unless course.homeworks_user(user).last.nil?
      lesson.priority == Lesson.another_lesson(course.homeworks_user(user).last.lesson_id)
    end
  end
end
