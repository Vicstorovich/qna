class Api::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  respond_to :json

  rescue_from Exception, with: :respond_with_enthernal_error

  rescue_from CanCan::AccessDenied, NotAuthorized, with: :respond_with_enthernal_authorized

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :respond_with_enthernal_found

  private

  def respond_with_success(response, status = 200)
    render json: response, status: status
  end

  def respond_with_enthernal_error(exception)
    response = { success: false, message: 'Enthernal Error' }
    response[:debug] = exception.message unless Rails.env.prodaction?

    render json: response, status: 500
  end

  def respond_with_enthernal_authorized(exception)
    response = { success: false, message: 'Not Authorized' }
    response[:debug] = exception.message unless Rails.env.prodaction?

    render json: response, status: 401
  end

  def respond_with_enthernal_found(exception)
    response = { success: false, message: 'Not1 Found' }
    response[:debug] = exception.message unless Rails.env.prodaction?

    render json: response, status: 404
  end

  def current_user
    if has_valid_auth_type?
      user = User.find(auth['user'])
      if user
        @current_user ||= user
      end
    end
  end

  def authentication_user!
    raise NotAuthorized unless current_user.present?
  end

  def auth_header
    request.headers['Authorization'].to_s.scan(/Bearer (.*)$/).flatten.last
  end

  def has_valid_auth_type?
    !!request.headers['Authorization'].to_s.scan(/Bearer/).flatten.first
  end

  def auth
    Auth.decode(auth_header) || {}
  end
end
