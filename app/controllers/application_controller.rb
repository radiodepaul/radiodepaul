class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone

  def set_timezone
    Time.zone = 'Central Time (US & Canada)'
  end
  
  def validate_access(allowed_roles)
          if current_user.isAdmin? || allowed_roles.include?(current_user.position)
                  return true
          end
          redirect_to root_url, :notice => "Restricted Access."
          return false
  end

  private

  def markdown
    RDiscount.new(self).to_html
  end

end
