class Dashboard::ParticipatedCoursesController < Dashboard::BaseController
  def index
    @courses = current_user.participated_courses
  end

  def create
    if !current_user.not_participate_in_course?(course)
      # current_user.participated_courses << course
      current_user.participated_courses.push(course) # а так можно?
    else
      flash[:notice] = t('.text1') unless current_user.expelled_from_course?(course)
    end

    redirect_to courses_path
  end

  def destroy
    current_user.participated_courses.delete(course) if current_user.expelled_from_course?(course)

    flash[:notice] = t('.text1')
    redirect_to courses_path
  end

  private

  def course
    course ||= Course.find(params[:course_id] || params[:id])
  end
end
