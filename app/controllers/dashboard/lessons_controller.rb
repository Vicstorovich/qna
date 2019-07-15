class Dashboard::LessonsController < Dashboard::BaseController
  def index
    @lessons = course.lessons.page(params[:page]).per(5)
  end

  def new
    @lesson = course.lessons.build
  end

  def create
    @lesson = course.lessons.build
    @lesson.assign_attributes(lesson_params)

    if @lesson.save
      flash[:notice] = "Your lesson successfully created."
      redirect_to dashboard_course_lessons_path
    else
      render :new
    end
  end

  def show
    @lesson= course.lessons.find(params[:id])
  end

  def edit; end

  def update
    if lesson.update lesson_params
      flash[:notice] = "The lesson was updated successfully."
      redirect_to dashboard_course_lessons_path
    else
      render :edit
    end
  end

  def destroy
    lesson.destroy

    flash[:notice] = "lesson was successfully deleted"
    redirect_to dashboard_course_lessons_path
  end

  def edit_order
    @lessons = course.lessons
  end

  def update_order
    if course.lessons.update(params[:lessons].keys, params[:lessons].values)
      flash[:notice] = "Order lessons updated"
      redirect_to dashboard_course_lessons_path
    else
      render :edit_order
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def lesson
    @lesson ||= course.lessons.find(params[:id])
  end
  helper_method :lesson

  def lesson_params
    params.require(:lesson).permit(:title, :description, :conspectus, :tell_homework,
     :image, :video, :draft, :priority)
  end
end
