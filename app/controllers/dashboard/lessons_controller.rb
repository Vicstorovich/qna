class Dashboard::LessonsController < Dashboard::BaseController
  before_action :lesson_build, only: %i[new create]
  before_action :course

  load_and_authorize_resource

  def index
    @lessons = course.lessons.page(params[:page]).per(5)
  end

  def new; end

  def create
    if @lesson.save
      flash[:notice] = t('.notice_new')
      redirect_to sti_dashboard_course_lesson_path
    else
      render :new
    end
  end

  def show
    @lesson = course.lessons.find(params[:id])
  end

  def edit; end

  def update
    if lesson.update lesson_params
      flash[:notice] = t('.notice_update')
      redirect_to sti_dashboard_course_lesson_path
    else
      render :edit
    end
  end

  def destroy
    lesson.destroy

    flash[:notice] = t('.notice_delete')
    redirect_to dashboard_course_lessons_path
  end

  def edit_order
    @lessons = course.lessons
  end

  def update_order
    if course.lessons.update(params[:lessons].keys, params[:lessons].values)
      flash[:notice] = t('.order_update')
      redirect_to dashboard_course_lessons_path
    else
      render :edit_order
    end
  end

  private

  def type
    Course.types.include?(params[:type]) ? params[:type] : 'Course'
  end

  def sti_dashboard_course_lesson_path
    send "dashboard_#{type.underscore}_lessons_path"
  end

  def course
    @course ||= Course.find(params["#{type.underscore}_id".to_sym])
  end
  helper_method :course

  def lesson
    @lesson ||= course.lessons.find(params[:id])
  end
  helper_method :lesson

  def lesson_params
    params.require(:lesson).permit(:title, :description, :conspectus, :tell_homework,
                                   :image, :video, :draft, :priority, :start_date)
  end

  def lesson_build
    @lesson = params[:lesson].present? ? course.lessons.build(lesson_params) : course.lessons.build
  end
end
