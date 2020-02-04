class  Api::AuthTokensController <  Api::BaseController
  def create


    raise NotAuthorized if auth_token.blank?

    respond_with_success({success: true, auth_token: auth_token}, 201)
  end
end
