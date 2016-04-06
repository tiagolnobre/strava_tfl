require "rspec"
# require 'webmock'
# include WebMock::API

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require File.expand_path('../../config/application', __FILE__)

RSpec.configure do |c|
  c.color = true
  c.formatter = :documentation

  c.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  c.order = :random
  Kernel.srand c.seed

  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end

  c.mock_with :rspec
  c.expect_with :rspec
  c.raise_errors_for_deprecations!

  c.include Rack::Test::Methods
end
