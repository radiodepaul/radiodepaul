class Manager < ActiveRecord::Base
  belongs_to :person
  before_save :blanks_to_nils
  validate :position, :presence => true
  
  def blanks_to_nils
     self.office_hours = nil if self.office_hours.blank?
     self.email = nil if self.email.blank?
     self.phone_number = nil if self.phone_number.blank?
  end
  
  def as_json(options={})
      { :id => self.person.id,
        :name => self.person.first_last_name,
        :position => self.position,
        :office_hours => self.office_hours,
        :email => self.email,
        :phone => self.phone_number,
        :facebook => self.person.facebook_username,
        :twitter => self.person.twitter_username,
        :linkedin => self.person.linkedin_username,
        :website => self.person.website_url,
        :photo => self.person.avatar.square.medium.url }
  end
end