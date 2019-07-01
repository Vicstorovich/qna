class LessonsController < ApplicationController
  def index
    @lessons = course.lessons.draft.sort_lessons.page(params[:page]).per(2)
  end

  def show
    @lesson = course.lessons.find(params[:id])
  end
end
