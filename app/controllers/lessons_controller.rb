class LessonsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    if course.user_not_participant?(current_user)
      @lessons = course.lessons.not_draft.page(params[:page]).per(5)
    else
      render file: "public/422.html"
    end
  end

  def show
    if course.lesson_available_user?(lesson, current_user)
      @lesson = course.lessons.find(params[:id])
    else
      render file: "public/422.html"
    end
  end

  private

  def lesson
    @lesson ||= course.lessons.find(params[:id])
  end
  helper_method :lesson

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
