class PagesController < ApplicationController
  
  def welcome
  end

  def home
    @shows = current_person.try(:shows)
    @person = current_person
  end

  def application_success
    render :layout => 'application'
  end

    private

end
