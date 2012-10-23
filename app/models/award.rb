class Award < ActiveRecord::Base
  attr_accessible :for, :name, :year, :award_organization_id
  belongs_to :award_organization
  has_and_belongs_to_many :people
  accepts_nested_attributes_for :people

  validates :for, :presence => true
  validates :award_organization, :presence => true
  validates :year, :presence => true

  def as_json(options={})
    {:id => self.id,
      :name => self.name,
      :for => self.for,
      :year => self.year,
      :award_organization => self.award_organization
    }
  end
end
