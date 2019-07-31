class Dashboard::CoursesController < Dashboard::BaseController
  def index
    @courses = current_user.courses.all.page(params[:page]).per(2)
  end

  def show
    @course_users = course.course_users
  end

  def destroy
    course.destroy

    flash[:notice] = t(".destroy")
    redirect_to dashboard_courses_path
  end

  private

  def course
    @course ||= current_user.courses.find(params[:id])
  end
  helper_method :course
end
