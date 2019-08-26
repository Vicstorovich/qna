class CourseParticipantsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, @course_users
    @course_users = Course.find(params[:course_id]).course_users
  end
end
