class Dashboard::RecordedCoursesController < Dashboard::CoursesController

  private

  def course_params
    params.require(:recorded_course).permit(:type, :name, :image,
     :number_hours_video, course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end

  def build_course
    @course = params[:course].present? ? current_user.courses.recorded_courses.build(course_params) : current_user.courses.recorded_courses.build
  end
end
