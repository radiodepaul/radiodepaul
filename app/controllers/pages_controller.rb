class PagesController < ApplicationController
  before_filter :authenticate_person!, :except => [:welcome]
  require 'exits'

  def get_analytics_profile
    profile = Garb::Management::Profile.all.first
    @analytics = Exits.results(profile, :filters => {:page_path.contains => '/'})
  end

  def welcome
  end

  def home
    #get_analytics_profile
    @shows = current_person.try(:shows)
    @person = current_person
  end

  def application_success
    render :layout => 'application'
  end

    private

end
