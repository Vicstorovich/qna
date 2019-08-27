class Dashboard::CoursesController < Dashboard::BaseController
  before_action :build_course, only: [:new, :create]
  before_action :course, only: [:update, :destroy, :edit]

  load_and_authorize_resource

  def index
    @courses = current_user.courses.all.page(params[:page]).per(2)
  end

  def new
  end

  def create
    if @course.save
      flash[:notice] = t(".create")
      redirect_to dashboard_courses_path
    else
      render :new
    end
  end

  def update
    if course.update course_params
      flash[:notice] = t(".update")
      redirect_to dashboard_courses_path
    else
      render :edit
    end
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

  def course_params
    params.require(:course).permit(:type, :name, :image,
     :number_hours_video, :number_hours_practice, :course_start_date,
      :course_end_date,course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end

  def build_course
    @course = params[:course].present? ? current_user.courses.build(course_params) : current_user.courses.build
  end
end
