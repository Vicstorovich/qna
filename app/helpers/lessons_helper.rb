module LessonsHelper
  def define_an_even_odd_lesson(course, lesson)
    if lesson.id % 2 == 0
      content_tag :div, class: "lesson-even" do
        content_tag :li do
          link_to lesson.title, course_lesson_path(course,lesson)
        end
      end
    else
      content_tag :div, class: "lesson-odd" do
        content_tag :li do
          link_to lesson.title, course_lesson_path(course,lesson)
        end
      end
    end
  end

  def view_homework_user_this_lesson(lesson)
    if current_user.homeworks.select_lessons(lesson.id).present?
      current_user.homeworks.select_lessons(lesson.id).last.body
    end
  end
end
