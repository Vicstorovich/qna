class Dashboard::CoursesController < Dashboard::BaseController
  def index
    @courses = current_user.courses.all.page(params[:page]).per(2)
  end

  def show
    @course_users = course.course_users

    @par = params
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      flash[:notice] = "Your course successfully created."
      redirect_to dashboard_courses_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if course.update course_params
      flash[:notice] = "The course was updated successfully."
      redirect_to dashboard_courses_path
    else
      render :edit
    end
  end

  def destroy
    course.destroy

    flash[:notice] = "Course was successfully deleted"
    redirect_to dashboard_courses_path
  end

  private

  def course
    @course ||= current_user.courses.find(params[:id])
  end
  helper_method :course

  def course_params
    params.require(:course).permit(:name, :image, course_users_attributes: [
      :id, :_destroy, :user_id
    ] )
  end
end
