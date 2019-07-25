module LessonsHelper
  def view_homework_user_this_lesson(lesson)
    if current_user.homeworks.select_lesson(lesson.id).present?
      current_user.homeworks.select_lesson(lesson.id).last.body
    end
  end

  def lesson_start_date(lesson)
    if lesson.start_date.nil?
      "0"
    else
      lesson.start_date
    end
  end

  def another_lesson?(course, lesson, user)
    lesson.priority == another_lesson(course, user)
  end

  def another_lesson(course, user)
    unless course.homeworks.where(user_id: user.id).last.nil?
      Lesson.find(course.homeworks.where(user_id: user.id).last.lesson_id).priority + 1
    end
  end

  def lesson_one?(course, lesson)
    one_lesson_piority(course) == lesson.priority
  end

  def one_lesson_piority(course)
    priority = course.lessons.map do |l|
                l.priority
              end
    priority.first
  end
end
