require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module RadioDePaulWebsite2
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local

    config.encoding = 'utf-8'

    config.filter_parameters += [:password]

    config.assets.enabled = true
    config.assets.version = '1.0'

    config.gem 'rdiscount'
    #
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  end
end
