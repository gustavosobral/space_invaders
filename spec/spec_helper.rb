# frozen_string_literal: true

if ENV['GEM_ENV'] == 'travis'
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'
SimpleCov.start do
  add_group 'Gem',  '/lib'
  add_group 'Core', '/lib/space_invaders/core'
  add_filter '/spec/'
end

require 'bundler/setup'
require 'space_invaders'
require 'fakefs/spec_helpers'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.include Helpers

  config.example_status_persistence_file_path = '.rspec_status'
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
