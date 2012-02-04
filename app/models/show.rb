class Show < ActiveRecord::Base
  attr_accessible :title, :genre, :short_description, :long_description, :facebook_page_username,
                  :twitter_username, :email, :website_url, :attachments_attributes, :avatar, :remove_avatar, :avatar_cache, :remote_avatar_url
  has_many :hostings, :dependent => :destroy
  has_many :people, :through => :hostings
  has_many :slots
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  before_save :blanks_to_nils  
  mount_uploader :avatar, AvatarUploader
  
  validates :title, :presence => true, :uniqueness => true

  def convert_markdown(input)
    markdown = RDiscount.new(input)
    return markdown.to_html
  end

  def get_hosts 
    hosts = Array.new
    self.people.each do |person|
      hosts.push :name => person.first_last_name,:id => person.id.to_s, :photo_thumb => person.avatar.square.thumb.url
    end
    return hosts
  end
  def get_podcasts 
    attachments = Array.new
    self.attachments.each do |attachment|
      x = {:title => attachment.title, :description => attachment.description, :contributors => attachment.description, :file_url => attachment.file.url}
      attachments.push x
    end
    return attachments
  end

  def get_scheduled_slots
    scheduled_slots = Array.new
    self.slots.each do |slot|
      scheduled_slots.push :slot => slot.time_days
    end
    return scheduled_slots
  end
  
  def blanks_to_nils
     self.genre = nil if self.genre.blank?
     self.short_description = nil if self.short_description.blank?
     self.long_description = nil if self.long_description.blank?
     self.facebook_page_username = nil if self.facebook_page_username.blank?
     self.twitter_username = nil if self.twitter_username.blank?
     self.email = nil if self.email.blank?
     self.website_url = nil if self.website_url.blank?
  end
  
  def as_json(options={})
       {:id => self.id,
        :title => self.title,
        :genre => self.genre,
        :hosts => get_hosts,
        :scheduled_slots => get_scheduled_slots,
        :short_description => self.short_description,
        :long_description => self.long_description,
        :facebook => self.facebook_page_username,
        :twitter => self.twitter_username,
        :email => self.email,
        :website => self.website_url,
        :podcasts => get_podcasts,
        :photo_thumb => self.avatar.square.thumb.url,
        :photo_small => self.avatar.square.small.url,
        :photo_medium => self.avatar.square.medium.url,
        :photo_large => self.avatar.square.large.url }
   end
end
