class CoursesController < ApplicationController
  before_action :find_course, only: %i[destroy update edit]

  def index
    @courses = Course.all.page(params[:page]).per(3)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @course.update course_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to root_path
  end

  private

  def find_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :image)
  end
end
