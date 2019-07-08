class Dashboard::CourseUsersController < Dashboard::BaseController
  def allow_deny_participation
    if course.ban == true
      course.subscribe
    else
      course.unsubscribe
    end
    redirect_back(fallback_location: dashboard_courses_path)
  end

  private

  def course
    @course_user ||= CourseUser.find(params[:id])
  end
end
