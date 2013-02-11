class Show < ActiveRecord::Base
  include Randomizable

  attr_accessible :title, :genre_list, :short_description, :long_description, :facebook_page_username, :twitter_username, :website_url, :email, :avatar_cache, :remote_avatar_url, :hosts_attributes

  scope :current, where("id in (select show_id from slots where quarter = '#{Settings.active_schedule}')")
  scope :active, current.where(archived: false)
  scope :archived, where(archived: true)

  has_and_belongs_to_many :hosts, class_name: 'Person', join_table: 'people_shows'
  has_many :slots
  has_many :schedules, through: :slots
  has_many :podcasts, class_name: 'Attachment', as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :podcasts, allow_destroy: true
  accepts_nested_attributes_for :hosts, allow_destroy: true

  acts_as_taggable_on :genres

  mount_uploader :avatar, AvatarUploader

  validates :title, presence: true, uniqueness: true

  def thumb_url
    square_avatar.thumb.url
  end

  def small_url
    square_avatar.small.url
  end

  def medium_url
   square_avatar.medium.url
  end

  def large_url
   square_avatar.large.url
  end

  private

  def square_avatar
    avatar.square
  end
end
