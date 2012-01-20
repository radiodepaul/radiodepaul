class Person < ActiveRecord::Base
  has_many :hostings, :dependent => :destroy
  has_many :shows, :through => :hostings
  before_save :blanks_to_nils
  mount_uploader :avatar, AvatarUploader

  def first_last_name
    return self.first_name + ' ' + self.last_name
  end

  def last_first_name
    return self.last_name + ', ' + self.first_name
  end

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def get_shows
    shows = Array.new
    self.shows.each do |show|
      shows.push :show_title => show.title, :show_id => show.id.to_s, :show_photo_thumb => show.avatar.thumb.url
    end
    return shows
  end
  
  def blanks_to_nils
     self.nickname = nil if self.nickname.blank?
     self.bio = nil if self.bio.blank?
     self.influences = nil if self.influences.blank?
     self.major = nil if self.major.blank?
     self.hometown = nil if self.hometown.blank?
     self.class_year = nil if self.class_year.blank?
     self.email = nil if self.email.blank?
     self.facebook_username = nil if self.facebook_username.blank?
     self.twitter_username = nil if self.twitter_username.blank?
     self.linkedin_username = nil if self.linkedin_username.blank?
     self.website_url = nil if self.website_url.blank?
     self.depaul_id = nil if self.depaul_id.blank?
  end

  def as_json(options={})
      { :id => self.id,
        :name => self.first_last_name,
        :nickname => nickname,
        :shows => get_shows,
        :bio => self.bio,
        :influences => self.influences,
        :major => self.major,
        :hometown => self.hometown,
        :class_year => self.class_year,
        :email => self.email,
        :facebook => self.facebook_username,
        :twitter => self.twitter_username,
        :linkedin => self.linkedin_username,
        :website => self.website_url,
        :photo_thumb => self.avatar.thumb.url,
        :photo_small => self.avatar.small.url,
        :photo_medium => self.avatar.medium.url,
        :photo_large => self.avatar.large.url }
  end

end
