class Dashboard::OnlineIntensesController < Dashboard::CoursesController

  private

  def course_params
    params.require(:online_intense).permit(:type, :name, :image,
     :number_hours_video, :number_hours_practice, :course_start_date,
      :course_end_date,course_users_attributes: %i[id _destroy user_id],
       lessons_attributes: %i[id title priority] )
  end

  def build_course
    @course = params[:course].present? ? current_user.courses.online_intenses.build(course_params) : current_user.courses.online_intenses.build
  end
end
