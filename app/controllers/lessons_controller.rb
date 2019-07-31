class LessonsController < ApplicationController
  def index
    if course.user_not_participant?(current_user)
      @lessons = course.lessons.not_draft.page(params[:page]).per(5)
    else
      render file: "public/422.html"
    end
  end

  def show
    if course.user_not_participant?(current_user)
      @lesson = course.lessons.find(params[:id])
    else
      render file: "public/422.html"
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
