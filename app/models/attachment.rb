class Attachment < ActiveRecord::Base
  attr_accessible :title, :description, :contributors, :file, :file_cache
  mount_uploader :file, FileUploader
  belongs_to :attachable, :polymorphic => true
end
