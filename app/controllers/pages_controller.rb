class PagesController < ApplicationController

  def welcome
    @shows = Show.random(25)
  end

  def home
    @shows = current_person.shows
    @person = current_person
  end
end
