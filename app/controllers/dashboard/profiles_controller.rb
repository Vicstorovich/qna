class Dashboard::ProfilesController < Dashboard::BaseController
  skip_authorization_check

  def edit; end

  def update
    if user_params[:password].present?
      succes = current_user.update(user_params)
    else
      succes = current_user.update_without_password(user_params)
    end

    if succes
      sign_in current_user, bypass: true
      flash[:notice] = t(".update")
      if current_user.has_role?(:mentor)
        redirect_to dashboard_courses_path
      else
        redirect_to courses_path
      end
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
