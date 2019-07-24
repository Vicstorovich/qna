class PasswordsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      @user.send_reset_password_instructions!

      render :create
    else
      @error = t(".error")

      render :new
    end
  end

  def edit
    @user = User.find_by!(reset_password_token: params[:token])
  end

  def update
    @user = User.find_by!(reset_password_token: params[:token])

    if @user.update(password_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
