class Show < ActiveRecord::Base
  attr_accessible :title, :short_description, :long_description, :facebook_page_username, :twitter_username, :email, :website_url, :attachments_attributes, :avatar, :remove_avatar, :avatar_cache, :remote_avatar_url, :genre_list, :hostings_attributes

  # relationships
  has_many :hostings, :dependent => :destroy
  has_many :hosts, :through => :hostings, source: :person
  has_many :slots
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :podcasts, class_name: 'Attachment', as: :attachable, :dependent => :destroy

  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :hostings, :allow_destroy => true
  acts_as_taggable_on :genres

  mount_uploader :avatar, AvatarUploader
  
  validates :title, :presence => true, :uniqueness => true

  def convert_markdown(input)
    RDiscount.new(input).to_html
  end

  def active_slots
    self.slots.where(quarter: Settings.active_schedule)
  end
  
  def as_json(options={})
    options[:include] ||= [:hosts]
    options[:methods] ||= [:active_slots]

    super(options)
  end
end
