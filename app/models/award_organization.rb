class AwardOrganization < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :awards
  validates :name, :presence => true, :uniqueness => true

  def as_json(options={})
    {:id => self.id,
      :name => self.name,
      :url => self.url || '',
    }
  end
end
