class Dashboard::ParticipatedCoursesController < Dashboard::BaseController
  def index
    @courses = current_user.participated_courses
  end

  def create
    if current_user.participate_in_course?(course)
      flash[:notice] = "You are expelled from the course !!!"
    else
      current_user.participated_courses << course
    end

    redirect_to courses_path
  end

  def destroy
    current_user.participated_courses.delete(course)

    flash[:notice] = "You unsubscribed from the course !!!"
    redirect_to courses_path
  end

  private

  def course
    @course ||= Course.find(params[:course_id] || params[:id])
  end
end
