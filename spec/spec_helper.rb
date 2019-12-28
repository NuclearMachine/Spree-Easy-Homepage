require 'simplecov'
SimpleCov.start do
  add_filter 'spec/dummy'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib/spree'
end

ENV['RAILS_ENV'] = 'test'

begin
  require File.expand_path('../dummy/config/environment', __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Please ensure you have run `bundle exec rake test_app`'
  exit
end

require 'rspec/rails'
require 'ffaker'
require 'pry'
require 'shoulda/matchers'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.fail_fast = ENV['FAIL_FAST'] || false

  config.infer_spec_type_from_file_location!
  config.include Spree::TestingSupport::UrlHelpers

  config.raise_errors_for_deprecations!
  
  config.color = true
  config.default_formatter = 'doc'

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end  
  
  config.order = 'random'
end
