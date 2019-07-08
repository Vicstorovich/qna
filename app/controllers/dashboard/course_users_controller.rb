class Dashboard::CourseUsersController < Dashboard::BaseController
  def pay_off_course
    course_user.unsubscribe

    redirect_back(fallback_location: dashboard_courses_path)
  end

  def enroll_for_course
    course_user.subscribe

    redirect_back(fallback_location: dashboard_courses_path)
  end

  private

  def course_user
    course ||= current_user.courses.find(params[:course_id])
    course_user ||= course.course_users.find(params[:id])
  end
end
