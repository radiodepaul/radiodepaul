class Podcast < ActiveRecord::Base
  mount_uploader :file, FileUploader

  belongs_to :show

  validates :title, :presence => true

  alias_attribute :type, :podcast_type
end
