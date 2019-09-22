require "application_responder"

class ApplicationController < ActionController::Base
  def self. my_http_basic_authenticate_with(login, password)
    return unless ENV['PROTECT_WITH_HTTP_BASIC'].present?

    http_basic_authenticate_with name: login, password: password
  end

  my_http_basic_authenticate_with(ENV.fetch('ADMIN_LOGIN'), ENV.fetch('ADMIN_PASSWORD'))

  self.responder = ApplicationResponder
  respond_to :html

  check_authorization unless: :devise_controller?

  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Отказано в доступе на #{exception.action} #{exception.subject.inspect}"

    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.json { render json: exception.message, status: :forbidden }
      format.js { render json: exception.message, status: :forbidden }
    end
  end

  def default_url_options
    { lang: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize

    @current_ability = Ability.new(current_user, params[:share_key], controller_namespace)
  end

  protected

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  def extract_locale
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
