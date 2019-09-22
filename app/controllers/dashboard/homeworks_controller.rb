class Dashboard::HomeworksController < Dashboard::BaseController
  load_and_authorize_resource

  def index
    @lessons = course.lessons.all

    if params[:lesson_id].present? || params.has_value?('0')
      @homeworks = course.homeworks.select_lesson(params[:lesson_id])
      @lesson_title = @lessons.find(params[:lesson_id]).title
    else
      @homeworks = course.homeworks
      @lesson_title = "all"
    end

    @homeworks = @homeworks.page(params[:page]).per(5)
  end

  def destroy
    authorize! :destroy, @homework
    homework.destroy

    flash[:notice] = t(".delete")
    redirect_to dashboard_course_homeworks_path(course)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def homework
    @homework ||= course.homeworks.find(params[:id])
  end
  helper_method :homework

  def homework_params
    params.require(:homework).permit(:body)
  end
end
