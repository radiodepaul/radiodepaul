class Person < ActiveRecord::Base
  include Randomizable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  scope :active,   where(archived: false)
  scope :archived, where(archived: true)
  scope :managers, where('id in (select person_id from positions)')

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :shows
  accepts_nested_attributes_for :shows, :allow_destroy => true

  has_many :podcasts, through: :shows

  has_and_belongs_to_many :awards
  accepts_nested_attributes_for :awards

  has_one  :position, dependent: :nullify
  delegate :title, to: :position, prefix: false, allow_nil: true

  before_validation(:on => :create) do
    reset_password!
  end
  after_create :send_welcome_email

  validates :first_name, :presence => true
  validates :last_name,  :presence => true

  def after_token_authentication
    update_attributes :authentication_token => nil
  end

  def name
    @name ||= UserName.new(self)
  end

  delegate :fullname, :last_first_name, :anonymized, to: :name, prefix: false

  def reset_password!(new_password = Devise.friendly_token.first(8))
    self.password = new_password
    self.password_confirmation = new_password

    if valid?
      clear_reset_password_token
      after_password_reset
    end

    Notifier.welcome(@person, new_password).deliver if save
  end

  def holds_position?(title)
    self.title == title
  end

  def convert_markdown(input)
    RDiscount.new(input).to_html
  end

  def send_welcome_email
    send_reset_password_instructions
    self.welcome_email_sent_at = Time.now.utc
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

  def find_for_database_authentication(conditions={})
      where('username = ?', conditions[:email]).limit(1).first ||
      where('email = ?',    conditions[:email]).limit(1).first
  end
end
