class UsersMailer < ApplicationMailer
  def reset_password_instructions(user)
    @user = user

    mail to: @user.email, subject: 'Reset password!'
  end
end
