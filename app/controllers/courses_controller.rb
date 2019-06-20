class CoursesController < ApplicationController
  def index
    @courses = per_page(Course, 1)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:notice] = "Your course successfully created."
      redirect_to courses_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if course.update course_params
      flash[:notice] =  "The course was updated successfully."
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    course.destroy

    flash[:notice] = "Course was successfully deleted"
    redirect_to courses_path
  end

  private

  def course
    @course ||= Course.find(params[:id])
  end
  helper_method :course

  def course_params
    params.require(:course).permit(:name, :image)
  end
end
