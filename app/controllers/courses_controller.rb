class CoursesController < ApplicationController
  def index
    authorize! :read, Course
    @courses = Course.all.page(params[:page]).per(2)
  end
end
