# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RadioDePaulWebsite2::Application.initialize!

# Sendgrid setup
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => ENV['SENDGRID_DOMAIN'],
  :address => ENV['SENDGRID_ADDRESS'],
  :port => ENV['SENDGRID_PORT'],
  :authentication => :plain,
  :enable_starttls_auto => true
}
