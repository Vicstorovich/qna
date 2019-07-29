module CoursesHelper
  def sti_courses_path(type = "course", course = nil, action = nil)
    send "dashboard_#{format_sti(action, type, course)}_path", course
  end

  def sti_course_path(type = "course", course = nil, action = nil)
    send "#{format_sti(action, type, course)}_path", course
  end

  def format_sti(action, type, course)
    action || course ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_dashboard_" : ""
  end
end
