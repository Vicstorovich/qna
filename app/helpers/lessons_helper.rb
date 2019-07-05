module LessonsHelper
  def view_homework_user_this_lesson(lesson)
    if current_user.homeworks.select_lesson(lesson.id).present?
      current_user.homeworks.select_lesson(lesson.id).last.body
    end
  end
end
