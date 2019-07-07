class CourseParticipantsController < ApplicationController
  def index
    @course_users = Course.find(params[:course_id]).course_users
  end
end
