ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start('rails')
  Dir["#{Rails.root}/{app,lib,spec/support}/**/*.rb"].each { |f| load f }
end

# Prevent database truncation if the environment is production
abort('ABORT! Production mode!') if Rails.env.production?
require 'rspec/rails'
require 'devise'
require 'factory_girl'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'faker'
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

def zeus_running?
  File.exist? 'zeus.sock'
end

unless zeus_running?
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, devise: true
  config.extend ControllerMacros, devise: true
  config.include DummyTVDB, dummy_tvdb: true
  config.include Warden::Test::Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end

  # config.before(:all) { DeferredGarbageCollection.start }
  # config.after(:all) { DeferredGarbageCollection.reconsider }

  config.around(:each, type: :feature, js: true) do |example|
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    self.use_transactional_fixtures = false
    example.run
    self.use_transactional_fixtures = true
    DatabaseCleaner.clean
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :slow unless ENV['SLOW_SPECS']

  config.profile_examples = true if ENV['PROFILE']

  config.order = :random
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

Capybara.javascript_driver = :poltergeist

def extract_name
  ->(hash) { hash['series_name'] }
end
