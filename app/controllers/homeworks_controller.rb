class HomeworksController < ApplicationController
  before_action :authenticate_user!

  def create
    @homework = lesson.homeworks.build
    @homework.user = current_user
    @homework.assign_attributes(homework_params)

    flash[:notice] = t(".create") if @homework.save
    redirect_to course_lesson_path(course, lesson)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course

  def lesson
    @lesson ||= course.lessons.find(params[:lesson_id])
  end
  helper_method :lesson

  def homework
    @homework ||= lesson.homeworks.find(params[:id])
  end
  helper_method :homework

  def homework_params
    params.require(:homework).permit(:body)
  end
end
