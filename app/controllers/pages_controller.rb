class PagesController < ApplicationController
  layout :resolve_layout
  
  def welcome
    if logged_in?
      redirect_to home_path
    end
  end

  def home
    #if logged_in?
    #end
  end
  def application
  end

    private

    def resolve_layout
      case action_name
      when "welcome"
        "logged_out"
      else
        "application"
      end
    end

end
