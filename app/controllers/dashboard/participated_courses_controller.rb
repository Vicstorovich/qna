class Dashboard::ParticipatedCoursesController < Dashboard::BaseController
  def index
    @courses = current_user.participated_courses
  end

  def create
    current_user.participated_courses << course

    redirect_to courses_path
  end

  def destroy
    current_user.participated_courses.delete(course)

    redirect_to courses_path
  end

  private

  def course
    @course ||= Course.find(params[:course_id] || params[:id])
  end
end
