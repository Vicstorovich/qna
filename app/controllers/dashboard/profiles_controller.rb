class Dashboard::ProfilesController < Dashboard::BaseController
  def edit; end

  def update
    if current_user.update(user_params)
      flash[:notice] = "The profile was updated successfully."
      redirect_to dashboard_courses_path
    else
      render :edit
    end
  end

  private

  def profile
    @profile = current_user.profile
  end
  helper_method :profile

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      profile_attributes: %i[name avatar addres link avatar_cache])
  end
end
