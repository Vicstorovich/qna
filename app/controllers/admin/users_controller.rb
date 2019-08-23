class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def edit; end

  def update
    if user.update(permitted_params)
      redirect_to admin_users_path
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:email, role_ids:[])
  end

  def user
    @user = User.find(params[:id])
  end
  helper_method :user
end
