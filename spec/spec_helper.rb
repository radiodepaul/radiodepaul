require_relative 'base_spec_helper'
require 'shoulda-matchers'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include Devise::TestHelpers, type: :controller

  if defined? DatabaseCleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end
  end

  if defined? Sidekiq
    require 'sidekiq/testing'
  end
end
