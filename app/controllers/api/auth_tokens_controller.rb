class Api::AuthTokensController < Api::BaseController
  def create
    if params[:password].present? && params[:email].present?
      user = User.find_by(email: params[:email])
      if user.present? && user.valid_password?(params[:password])
        auth_token = Auth.issue({ user: user.id }, Time.now + 1.year)
      end
    end

    raise NotAuthorized if auth_token.blank?

    respond_with_success({ success: true, auth_token: auth_token }, 201)
  end
end
