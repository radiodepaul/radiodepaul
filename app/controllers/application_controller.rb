class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  protected

    def logged_in?
      unless session[:user_id]
        flash[:notice] = "You need to log in first."
        redirect_to root_url
        return false
      else
        return true
      end
    end
  
end