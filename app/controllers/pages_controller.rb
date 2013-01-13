class PagesController < ApplicationController
  before_filter :authenticate_person!, :except => [:welcome, :application_success]

  def welcome
    show_ids = Show.where("archived is FALSE AND avatar IS NOT NULL").select(:id).map( &:id )
    @shows = Show.find( (1..25).map { show_ids.delete_at( show_ids.size * rand ) } )
  end

  def home
    @shows = current_person.try(:shows)
    @person = current_person
  end
end
