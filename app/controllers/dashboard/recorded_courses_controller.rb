class Dashboard::RecordedCoursesController < Dashboard::CoursesController
  def new
    @course = RecordedCourse.new
  end

  def create
    @course = current_user.courses.recorded_courses.build(course_params)

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

  def destroy
    course.destroy

    flash[:notice] = t(".destroy")
    redirect_to dashboard_courses_path
  end

  private

  def course_params
    params.require(:recorded_course).permit(:type, :name, :image,
     :number_hours_video, course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end

  def build_course
    @course = params[:course].present? ? current_user.courses.recorded_courses.build(course_params) : current_user.courses.recorded_courses.build
  end
end
