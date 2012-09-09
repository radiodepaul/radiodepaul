class Podcast < ActiveRecord::Base
  mount_uploader :file, FileUploader
  
  validates :title, :presence => true
  
  def blanks_to_nils
     self.description = nil if self.description.blank?
     self.contributors = nil if self.contributors.blank?
  end
  
  def convert_markdown(input)
    markdown = RDiscount.new(input)
    return markdown.to_html
  end
  
  def as_json(options={})
       {:id => self.id,
        :type => self.podcast_type,
        :title => self.title,
        :description => self.description,
        :contributors => self.contributors + " // " + self.description,
        :file_url => self.file.url}
   end
end
