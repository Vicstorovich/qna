class CoursesController < ApplicationController
  before_action :authenticate_user!
  def index
    @courses = Course.all.page(params[:page]).per(2)
  end
end
