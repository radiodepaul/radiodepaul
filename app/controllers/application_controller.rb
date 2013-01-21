class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone
  helper_method :pretty_time, :pretty_date

  add_breadcrumb 'Home', :root_path

  def pretty_time(time = Time.now)
    time.strftime('%I:%M%p %Z')
  end

  def pretty_date(time = Time.now)
    time.strftime('%m/%d/%Y')
  end

  def set_timezone
    Time.zone = 'Central Time (US & Canada)'
  end

  def after_sign_in_path_for(resource)
    home_path
  end

  def isAdmin?
    if current_person.admin?
      return true
    end
    redirect_to root_url, :notice => 'Restricted Access.'
    return false
  end

  def validate_access(allowed_roles = Array[])
    if current_person.try(:admin?) || allowed_roles.include?(current_person.position)
            return true
    end
    redirect_to root_url, :notice => 'Restricted Access.'
    return false
  end

  private

  def markdown
    RDiscount.new(self).to_html
  end
end
