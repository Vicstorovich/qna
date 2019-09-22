class Dashboard::RecordedCoursesController < Dashboard::CoursesController

  resource_ancestor Course
  add_actions :new, :create, :update, :destroy

  private

  def permitted_params
    params.require(:recorded_course).permit(:type, :name, :image,
     :number_hours_video, course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end
end
