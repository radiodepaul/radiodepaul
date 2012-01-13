class PagesController < ApplicationController
  layout :resolve_layout
  
  def welcome
  end

  def home
    #if logged_in?
    #end
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
