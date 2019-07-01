class LessonsController < ApplicationController
  def index
    @lessons = course.lessons.not_draft.sort_lessons.page(params[:page]).per(2)
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
