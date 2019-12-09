source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
# gem 'sass-rails', '~> 5.0'
# gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
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
gem 'hamlit-rails'
gem 'simple_form'
gem 'kaminari'
gem 'carrierwave'
gem 'mini_magick', '~> 4.8'
# gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'redis-rails'
gem 'email_validator'
gem "cocoon"
gem 'dotenv-rails', groups: [:development, :test]
gem 'rails-i18n'
gem 'devise'
gem 'rolify'
gem 'cancancan'
gem 'has_scope'
gem "responders"
gem "webpacker"

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'rubocop-rspec', require: false
  gem 'seed_dump'
  gem 'letter_opener'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rack-console'
  gem 'spring-commands-rspec'
  gem 'spring-commands-rubocop'
  gem 'guard-bundler', require: false
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'guard-spring', require: false
  gem 'guard-livereload', '~> 2.5', require: false
  gem "rack-livereload"
  gem 'rails_real_favicon'
  gem 'router-visualizer'
  gem "ruby_warning_filter", "~> 1.0.0"
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'fuubar'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'rspec-rails', '~>3.8'
  gem 'launchy'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'rubycritic', require: false
