require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.test_framework :rspec,
            view_specs: false,
            helper_specs: false,
            routing_specs: false,
            request_specs: false

      g.helper          false
      g.stylesheets     false
      g.javascripts     false
    end

    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :en
    config.time_zone = ENV["TIME_ZONE"]
    # config.x.english_website_url = "http://www.application.en."
    # config.x.russian_website_url = "http://www.application.ru."
  end
end
