class HomeworksController < ApplicationController
  def new
    @homework = lesson.homeworks.build
  end

  def create
    @homework = lesson.homeworks.build
    @homework.assign_attributes(homework_params)

    flash[:notice] = "Your homework successfully created." if @homework.save
    redirect_to course_lesson_path(course, lesson)
  end

  private

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
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
