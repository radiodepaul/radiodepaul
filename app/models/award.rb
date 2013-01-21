class Award < ActiveRecord::Base
  attr_accessible :for, :name, :year, :award_organization_id
  belongs_to :award_organization

  has_and_belongs_to_many :people
  accepts_nested_attributes_for :people

  validates :for, :presence => true
  validates :year, :presence => true

  delegate :name, :url, to: :award_organization, prefix: true
end
