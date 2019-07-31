class Dashboard::RecordedIntensesController < Dashboard::CoursesController
  def new
    @course = RecordedIntense.new
  end

  def create
    @course = current_user.courses.build(course_params)

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

  private

  def course
    @course ||= current_user.courses.find(params[:id])
  end
  helper_method :course

  def course_params
    params.require(:recorded_intense).permit(:type, :name, :image,
     :number_hours_video, :number_hours_practice, course_users_attributes: %i[
        id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end
end
