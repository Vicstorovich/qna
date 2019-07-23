class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.valid_password?(params[:password])
      sign_in user

      flash[:notice] = t('.notice_yes')
      redirect_to dashboard_courses_path
    else
      flash[:notice] = t('.notice_no')
      render :new
    end
  end

  def destroy
    sign_out

    flash[:notice] = t(".notice")
    redirect_to root_path
  end
end
