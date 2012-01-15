class Attachment < ActiveRecord::Base
  attr_accessible :title, :description, :file
  mount_uploader :file, FileUploader
  belongs_to :attachable, :polymorphic => true
end
