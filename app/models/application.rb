class Application < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  scope :hired,    where(hired: true)
  scope :rejected, where(rejected: true)
  scope :archived, where(archived: true)
  scope :pending,  where(hired: false, rejected: false, archived: false)

  attr_accessible :anything_else, :bio, :campus_involvement, :co_hosts, :depaul_id, :email, :experience, :famous_person, :favorite_artists, :favorite_films, :favorite_tv_shows, :first_name, :gpa, :home_city, :home_state, :host_type, :influences, :last_name, :major, :phone, :podcast_topic, :position, :show_description, :show_genres, :show_name, :show_type, :why_depaul, :year, :avatar, :created_at, :genre_list, :avatar_cache, :remote_avatar_url, :twitter_username, :facebook_username, :tumblr_username, :why_listen, :why_work_here, :position_other, :hired, :rejected, :archived

  acts_as_taggable_on :genres

  with_options presence: true do |app|
    app.validates :first_name
    app.validates :last_name
    app.validates :depaul_id
    app.validates :email
    app.validates :bio
    app.validates :position
    app.validates :influences
    app.validates :why_work_here
  end

  validates :depaul_id, numericality: { only_integer: true }
  validates_format_of :email, with: /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, on: :create
  validates :avatar, presence: true, unless: :remote_avatar_url_filled?
  validates_format_of :remote_avatar_url, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, on: :create, message: 'has an invalid format', if: :remote_avatar_url_filled?

  def remote_avatar_url_filled?
    !remote_avatar_url.blank?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def last_first_name
    "#{last_name}, #{first_name}"
  end
end
