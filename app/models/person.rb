class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :authentication_token
  attr_accessible :first_name, :last_name, :nickname, :bio, :influences, :facebook_username, :linkedin_username, :website_url, :email, :major, :class_year, :hometown, :avatar, :depaul_id, :hostings_attributes, :twitter_username, :tumblr_username, :avatar_cache, :remote_avatar_url, :remove_avatar

  # relationships
  has_many :hostings, :dependent => :destroy
  has_many :shows, :through => :hostings
  accepts_nested_attributes_for :hostings, :allow_destroy => true
  has_and_belongs_to_many :awards
  accepts_nested_attributes_for :awards

  # callbacks
  before_save :blanks_to_nils
  before_validation(:on => :create) do
    self.set_password
  end
  #after_create :send_welcome_email

  # validation
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  def after_token_authentication
    update_attributes :authentication_token => nil
  end

  def first_last_name
    return self.first_name + ' ' + self.last_name
  end

  def last_first_name
    return self.last_name + ', ' + self.first_name
  end

  def set_password
    if self.password.nil? || self.password.blank?
      password = Devise.friendly_token.first(8)
      self.password = password
      self.password_confirmation = password
    end
  end

  def position
    manager = Manager.find_by_person_id(self.id)
    unless manager.nil?
      return manager.position
    end
  end
  
  def convert_markdown(input)
    markdown = RDiscount.new(input)
    return markdown.to_html
  end

  def send_welcome_email
    self.send_reset_password_instructions
  end

  def podcasts
    podcasts = Array.new
    self.shows.each do |show|
      show.attachments.each do |podcast|
        podcasts.push podcast
      end
    end
    return podcasts
  end

  def get_shows
    shows = Array.new
    self.shows.each do |show|
      shows.push :show_title => show.title, :show_id => show.id.to_s, :show_photo_thumb => show.avatar.square.thumb.url
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

  def replace_avatar_from(resource)
    self.avatar = resource.avatar.file
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
        :photo_thumb => self.avatar.square.thumb.url,
        :photo_small => self.avatar.square.small.url,
        :photo_medium => self.avatar.square.medium.url,
        :photo_large => self.avatar.square.large.url }
  end

  def self.find_for_database_authentication(conditions={})
      self.where("username = ?", conditions[:email]).limit(1).first ||
      self.where("email = ?", conditions[:email]).limit(1).first
  end
end
