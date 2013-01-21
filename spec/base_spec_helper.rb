ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'

RSpec.configure do |config|
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
end

# Rails.logger.level = 4
