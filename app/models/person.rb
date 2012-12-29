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
  has_many :shows, through: :hostings
  has_many :podcasts, through: :shows, source: :attachments

  accepts_nested_attributes_for :hostings, :allow_destroy => true
  has_and_belongs_to_many :awards
  accepts_nested_attributes_for :awards

  # callbacks
  before_validation(:on => :create) do
    self.set_password
  end
  after_create :send_welcome_email

  # validation
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  def after_token_authentication
    update_attributes :authentication_token => nil
  end

  def name
    "#{first_name} #{last_name}"
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

  def holds_position?(position)
    manager = Manager.find_by_person_id(self.id) 
    if manager && manager.position.capitalize == position.capitalize
      true
    else
      false
    end
  end
  
  def convert_markdown(input)
    markdown = RDiscount.new(input)
    return markdown.to_html
  end

  def send_welcome_email
    self.send_reset_password_instructions
  end

  def replace_avatar_from(resource)
    self.avatar = resource.avatar.file
  end

  def as_json(options={})
    options[:except]  ||= [:depaul_id, :phone, :welcome_email_sent_at]
    options[:include] ||= [:shows]
    options[:methods] ||= [:name, :position]
    
    super(options)
   end

  def self.find_for_database_authentication(conditions={})
      self.where("username = ?", conditions[:email]).limit(1).first ||
      self.where("email = ?", conditions[:email]).limit(1).first
  end
end
