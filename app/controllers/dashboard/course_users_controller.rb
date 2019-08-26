class Dashboard::CourseUsersController < Dashboard::BaseController
  authorize_resource

  def not_pupil
    course_user.unsubscribe

    redirect_back(fallback_location: dashboard_courses_path)
  end

  def pupil
    course_user.subscribe

    redirect_back(fallback_location: dashboard_courses_path)
  end

  private

  def course_user
    course = current_user.courses.find(params[:course_id])
    course_user = course.course_users.find(params[:id])
  end
end
