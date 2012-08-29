class PagesController < ApplicationController
  
  def welcome
  end

  def home
    #if logged_in?
    #end
  end

  def application_success
    render :layout => 'application'
  end

    private

end
