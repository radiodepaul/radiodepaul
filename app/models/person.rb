class Person < ActiveRecord::Base
  include Randomizable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  mount_uploader :avatar, AvatarUploader

  # relationships
  has_and_belongs_to_many :shows
  has_many :podcasts, through: :shows, source: :attachments

  accepts_nested_attributes_for :shows, :allow_destroy => true
  has_and_belongs_to_many :awards
  accepts_nested_attributes_for :awards

  # scopes
  scope :archived, where(archived: true)

  # callbacks
  before_validation(:on => :create) do
    set_password
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
    "#{last_name}, #{first_name}"
  end

  def set_password
    if password.nil? || password.blank?
      password = Devise.friendly_token.first(8)
      password = password
      password_confirmation = password
    end
  end

  def position
    manager = Manager.find(id)
    manager.position if manager
  end

  def holds_position?(position)
    position == position
  end
  
  def convert_markdown(input)
    RDiscount.new(input).to_html
  end

  def send_welcome_email
    send_reset_password_instructions
  end

  def replace_avatar_from(resource)
    avatar = resource.avatar.file
  end

  def avatar_url
    read_attribute(:avatar_url) || avatar.url
  end

  def thumb_url
    avatar.square.thumb.url
  end

  def small_url
    avatar.square.small.url
  end

  def medium_url
   avatar.square.medium.url
  end

  def large_url
   avatar.square.large.url
  end

  def as_json(options={})
    options[:except]  ||= [:depaul_id, :phone, :welcome_email_sent_at, :admin, :archived, :avatar]
    options[:include] ||= { shows: { only: [:id], methods: [:title, :thumb_url] } }
    options[:methods] ||= [:name, :position, :avatar_url, :thumb_url, :small_url, :medium_url, :large_url]
    
    super(options)
   end

  def find_for_database_authentication(conditions={})
      where('username = ?', conditions[:email]).limit(1).first ||
      where('email = ?', conditions[:email]).limit(1).first
  end
end
