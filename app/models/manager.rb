class Manager < ActiveRecord::Base
  belongs_to :person
  
  def get_shows
    shows = Array.new
    self.person.shows.each do |show|
      shows.push show.title
    end
    return shows
  end
  
  def as_json(options={})
      { :name => self.person.first_last_name,
        :position => self.position,
        :office_hours => self.office_hours,
        :email => self.email,
        :phone => self.phone_number,
        :shows => get_shows,
        :facebook => self.person.facebook_username,
        :twitter => self.person.twitter_username,
        :linkedin => self.person.linkedin_username,
        :website => self.person.website_url,
        :photo => self.person.avatar.small.url }
  end
end