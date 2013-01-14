class Show < ActiveRecord::Base
  include Randomizable

  default_scope    where(archived: false)
  scope :active,   where(archived: false)
  scope :archived, where(archived: true)

  has_and_belongs_to_many :hosts, class_name: 'Person'
  has_many :slots
  has_many :podcasts, class_name: 'Attachment', as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :podcasts, allow_destroy: true
  accepts_nested_attributes_for :hosts, allow_destroy: true

  acts_as_taggable_on :genres

  mount_uploader :avatar, AvatarUploader

  validates :title, :presence => true, :uniqueness => true

  def active_slots
    slots.where(quarter: Settings.active_schedule)
  end

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
