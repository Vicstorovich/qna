class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV.fetch('ADMIN_LOGIN'), password: ENV.fetch('ADMIN_PASSWORD')  if ENV['PROTECT_WITH_HTTP_BASIC'].present?

  check_authorization unless: :devise_controller?

  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.json { render json: exception.message, status: :forbidden }
      format.js { render json: exception.message, status: :forbidden }
    end
  end

  def default_url_options
    { lang: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
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
