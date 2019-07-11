class LessonsController < ApplicationController
  def index
    @lessons = course.lessons.not_draft.page(params[:page]).per(5)
  end

  def show
    @lesson = course.lessons.find(params[:id])
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
  helper_method :course
end
