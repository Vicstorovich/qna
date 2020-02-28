class Api::V1::CoursesController < Api::BaseController
  # before_action :authentication_user!

  def index
    courses = Course.with_course_participant_flag(current_user.id)

    respond_with_success courses
  end
end
