class Api::V1::CoursesController < Api::BaseController
  # before_action :authentication_user!

  def index
    courses = Course.all.includes(:course_users)

    respond_with_success courses
  end
end
