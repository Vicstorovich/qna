class CoursesController < ApplicationController
  def index
    @courses = Course.all.page(params[:page]).per(2)
  end
end
