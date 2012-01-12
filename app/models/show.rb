class Show < ActiveRecord::Base
  has_many :hostings
  has_many :people, :through => :hostings
  has_and_belongs_to_many :slots
  
  validates :title, :presence => true

end
