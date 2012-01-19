class Show < ActiveRecord::Base
  attr_accessible :title, :genre, :short_description, :long_description, :facebook_page_username,
                  :twitter_username, :email, :website_url, :attachments_attributes
  has_many :hostings, :dependent => :destroy
  has_many :people, :through => :hostings
  has_many :schedulings, :dependent => :destroy
  has_many :slots, :through => :schedulings
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  mount_uploader :avatar, AvatarUploader
  
  validates :title, :presence => true

  def get_hosts 
    hosts = Array.new
    self.people.each do |person|
      hosts.push [person.first_last_name, person.id.to_s, person.avatar.thumb.url]
    end
    return hosts
  end
  def get_podcasts 
    attachments = Array.new
    self.attachments.each do |attachment|
      attachments.push attachment.file.url
    end
    return attachments
  end

  def get_scheduled_slots
    scheduled_slots = Array.new
    self.slots.each do |slot|
      scheduled_slots.push slot.quarter_start_time_end_time
    end
    return scheduled_slots
  end

  def as_json(options={})
       {:id => self.id,
        :title => self.title,
        :hosts => get_hosts,
        :genre => self.genre,
        :scheduled_slots => get_scheduled_slots,
        :short_description => self.short_description,
        :long_description => self.long_description,
        :facebook => self.facebook_page_username,
        :twitter => self.twitter_username,
        :email => self.email,
        :website => self.website_url,
        :podcasts => get_podcasts,
        :photo_thumb => self.avatar.thumb.url,
        :photo_small => self.avatar.small.url,
        :photo_medium => self.avatar.medium.url,
        :photo_large => self.avatar.large.url }
   end

end
