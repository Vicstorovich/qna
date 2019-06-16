class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.valid_password?(params[:password])
      sign_in user

      redirect_to courses_path
    else
      render :new
    end
  end

  def destroy
    sign_out

    redirect_to root_path
  end
end
