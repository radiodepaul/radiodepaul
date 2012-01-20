class Podcast < ActiveRecord::Base
  mount_uploader :file, FileUploader
  
  validates :title, :presence => true
  
  def blanks_to_nils
     self.description = nil if self.description.blank?
     self.contributors = nil if self.contributors.blank?
  end
  
end