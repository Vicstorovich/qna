class Dashboard::CoursesController < Dashboard::BaseController
  include SimpleResource

  responders :flash, :http_cache
  resource_context :current_user
  paginate_collection 2
  add_actions :index, :create, :destroy
  authorize_resource

  def show
    @course_users = resource.course_users
  end

  private

  def permitted_params
    params.require(:course).permit(:type, :name, :image,
                                   :number_hours_video, :number_hours_practice, :course_start_date,
                                   :course_end_date, course_users_attributes: %i[id _destroy user_id],
                                                     lessons_attributes: %i[id title priority])
  end

  def after_actions_redirect_pash
    dashboard_courses_path
  end
end
