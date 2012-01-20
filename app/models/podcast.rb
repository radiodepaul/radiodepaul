class Podcast < ActiveRecord::Base
  mount_uploader :file, FileUploader
  
  validates :title, :presence => true
  
  def blanks_to_nils
     self.description = nil if self.description.blank?
     self.contributors = nil if self.contributors.blank?
  end
  
  def as_json(options={})
       {:id => self.id,
        :type => self.podcast_type,
        :title => self.title,
        :description => self.description,
        :contributors => self.contributors,
        :file_url => self.file.url}
   end
end