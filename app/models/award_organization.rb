class AwardOrganization < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :awards
  validates :name, :presence => true, :uniqueness => true
end
