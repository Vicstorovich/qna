class Dashboard::HomeworksController < Dashboard::BaseController
  def index
    @lessons = Lesson.all

    unless params[:lesson].nil? || params[:lesson][:lesson_id] == ""
      @homeworks = Homework.select_lessons(params[:lesson][:lesson_id]).
                    page(params[:page]).per(2)
    else
      @homeworks = Homework.all.page(params[:page]).per(2)
    end

    unless params[:lesson].nil? || params[:lesson][:lesson_id] == ""
      @lesson_title = Lesson.find_by(id: params[:lesson][:lesson_id]).title
      else
       @lesson_title = "all"
    end
  end

  def destroy
    homework.destroy

    flash[:notice] = "homework was successfully deleted"
    redirect_to dashboard_course_homeworks_path(course)
  end

  private

  def homework
    @homework ||= Homework.find(params[:id])
  end
  helper_method :homework

  def homework_params
    params.require(:homework).permit(:body)
  end
end
