class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone

  def set_timezone
    Time.zone = 'Central Time (US & Canada)'
  end
  
  private

  def markdown
    RDiscount.new(self).to_html
  end

end
