# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 5.2.2'

gem 'puma', '~> 3.12'
# gem 'sass-rails', '~> 5.0'
# gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'mini_racer'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Gems set in hand
gem 'carrierwave'
gem 'hamlit-rails'
gem 'kaminari'
gem 'mini_magick', '~> 4.9'
gem 'simple_form'
# gem 'bootstrap', '~> 4.3.1'
gem 'active_model_serializers'
gem 'cancancan'
gem 'cocoon'
gem 'devise'
gem 'dotenv-rails', groups: %i[development test]
gem 'email_validator'
gem 'has_scope'
gem 'jquery-rails'
gem 'jwt'
gem 'rails-i18n'
gem 'redis-rails'
gem 'responders'
gem 'rolify'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rubocop-rspec', require: false
  gem 'seed_dump'
end

group :development do
  gem 'guard-bundler', require: false
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'guard-spring', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'prettier'
  gem 'rack-livereload'
  gem 'rails_real_favicon'
  gem 'router-visualizer'
  gem 'ruby_warning_filter', '~> 1.0.0'
  gem 'spring'
  gem 'spring-commands-rack-console'
  gem 'spring-commands-rspec'
  gem 'spring-commands-rubocop'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~>3.8'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

gem 'rubycritic', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
