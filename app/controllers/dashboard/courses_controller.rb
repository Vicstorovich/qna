class Dashboard::CoursesController < Dashboard::BaseController
  def index
    @courses = Course.all.page(params[:page]).per(2)
  end

  def show
    @course_users = course.course_users
  end

  def new
    @course = current_user.courses.build
    @course.send(params[:data]).build
    @data = params[:data]
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      flash[:notice] = t('.text1')
      redirect_to dashboard_courses_path
    else
      render :new
    end
  end

  def edit
    course.course_users.build unless course.course_users.any?
   end

  def update
    if course.update course_params
      flash[:notice] = t('.text1')
      redirect_to dashboard_courses_path
    else
      render :edit
    end
  end

  def destroy
    course.destroy

    flash[:notice] = t('.text1')
    redirect_to dashboard_courses_path
  end

  private

  def course_type(arg)
    send(arg)
  end

  def course
    @course ||= current_user.courses.find(params[:id])
  end
  helper_method :course

  def course_params
    params.require(:course).permit(:name, :image, course_users_attributes: %i[
      id _destroy user_id], lessons_attributes: %i[id title priority],
      online_intensifes_attributes: %i[id number_hours_video number_hours_practice course_start_date course_end_date],
        recorded_intensifes_attributes: %i[id number_hours_video number_hours_practice],
        recorded_courses_attributes: %i[id number_hours_video] )
  end
end
