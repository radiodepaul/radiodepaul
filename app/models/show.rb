class Show < ActiveRecord::Base
  
  has_many :hostings
  has_many :people, :through => :hostings

  has_many :schedulings
  has_many :slots, :through => :schedulings
  
  mount_uploader :avatar, AvatarUploader
  
  validates :title, :presence => true

  def get_hosts 
    hosts = Array.new
    self.people.each do |person|
      hosts.push person.first_last_name
    end
    return hosts
  end

  def get_scheduled_slots
    scheduled_slots = Array.new
    self.slots.each do |slot|
      scheduled_slots.push slot.quarter_start_time_end_time
    end
    return scheduled_slots
  end

  def as_json(options={})
       {:title => self.title,
        :hosts => get_hosts,
        :genre => self.genre,
        :scheduled_slots => get_scheduled_slots,
        :short_description => self.short_description,
        :long_description => self.long_description,
        :facebook => self.facebook_page_username,
        :twitter => self.twitter_username,
        :email => self.email,
        :website => self.website_url }
   end

end
