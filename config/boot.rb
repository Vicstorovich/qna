ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.

# $VERBOSE = true
# require "ruby_warning_filter"
# $stderr = RubyWarningFilter.new($stderr)
