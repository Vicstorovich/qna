class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.valid_password?(params[:password])
      sign_in user

      flash[:notice] = "Signed in successfully."
      redirect_to courses_path
    else
      flash[:notice] = "Invalid Email or password."
      render :new
    end
  end

  def destroy
    sign_out

    flash[:notice] = "Signed out successfully."
    redirect_to root_path
  end
end
