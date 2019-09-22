class LessonsController < ApplicationController
  before_action :authenticate_user!

  has_scope :not_draft

  def index
    authorize! :access_to_course, course
    @lessons = apply_scopes(Lesson).page(params[:page]).per(5)
  end

  def show
    authorize! :access_to_lesson, course, lesson
    @lesson = course.lessons.find(params[:id])
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
