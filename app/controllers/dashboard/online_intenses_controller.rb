class Dashboard::OnlineIntensesController < Dashboard::CoursesController
  resource_ancestor Course
  add_actions :new, :create, :update, :destroy

  private

  def permitted_params
    params.require(:online_intense).permit(:type, :name, :image,
                                           :number_hours_video, :number_hours_practice, :course_start_date,
                                           :course_end_date, course_users_attributes: %i[id _destroy user_id],
                                                             lessons_attributes: %i[id title priority])
  end
end
