class Application < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_accessible :anything_else, :bio, :campus_involvement, :co_hosts, :depaul_id, :email, :experience, :famous_person, :favorite_artists, :favorite_films, :favorite_tv_shows, :first_name, :gpa, :home_city, :home_state, :host_type, :influences, :last_name, :major, :phone, :podcast_topic, :position, :show_description, :show_genres, :show_name, :show_type, :why_depaul, :year, :avatar, :created_at, :genre_list, :avatar_cache, :remote_avatar_url, :twitter_url, :facebook_url, :tumblr_url
  acts_as_taggable_on :genres
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :depaul_id, :presence => true, :numericality => { :only_integer => true }
  validates :email, :presence => true
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :on => :create
  validates :position, :presence => true
  validates :bio, :presence => true
  validates :bio, :presence => true
  validates :why_work_here, :presence => true
  validates_format_of :twitter_url, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, :on => :create, :message=>"has an invalid format", :if => :twitter_url_filled?
  validates_format_of :facebook_url, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, :on => :create, :message=>"has an invalid format", :if => :facebook_url_filled?
  validates_format_of :tumblr_url, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, :on => :create, :message=>"has an invalid format", :if => :tumblr_url_filled?

  def twitter_url_filled?
    !twitter_url.blank?
  end
  def facebook_url_filled?
    !facebook_url.blank?
  end
  def tumblr_url_filled?
    !tumblr_url.blank?
  end
  def first_last_name
    return self.first_name + ' ' + self.last_name
  end

  def last_first_name
    return self.last_name + ', ' + self.first_name
  end
end
