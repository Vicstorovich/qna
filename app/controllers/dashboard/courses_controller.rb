class Dashboard::CoursesController < Dashboard::BaseController
  def index
    @courses = current_user.courses.all.page(params[:page]).per(2)
  end

  def show
    @course_users = course.course_users
  end

  def new
    @course = type_class.new
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

  def edit
    course.course_users.build unless course.course_users.any?
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

  def course
    @course ||= current_user.courses.find(params[:id])
  end
  helper_method :course

  def course_params
    params.require(type.underscore.to_sym).permit(:type, :name, :image,
     :number_hours_video, :number_hours_practice, :course_start_date,
      :course_end_date,course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end

  def set_type
    @type = type
  end
  helper_method :set_type

  def type
    Course.types.include?(params[:type]) ? params[:type] : "Course"
  end

  def type_class
    type.constantize
  end
end
