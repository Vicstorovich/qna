class CourseParticipantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @course_users = Course.find(params[:course_id]).course_users
  end
end
