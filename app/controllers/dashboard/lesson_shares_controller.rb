class Dashboard::LessonSharesController < Dashboard::BaseController
  def create
    authorize! :share_lesson, lesson

    lesson.update!(share_key: SecureRandom.hex(4))
    redirect_to sti_dashboard_course_lesson_path
  end

  private

  def type
    Course.types.include?(params[:type]) ? params[:type] : 'Course'
  end

  def sti_dashboard_course_lesson_path
    send "dashboard_#{type.underscore}_lessons_path"
  end

  def course
    @course ||= Course.find(params["#{type.underscore}_id".to_sym])
  end

  def lesson
    @lesson ||= course.lessons.find(params[:lesson_id])
  end
end
