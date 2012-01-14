class Show < ActiveRecord::Base
  has_many :hostings
  has_many :schedulings
  has_many :people, :through => :hostings
  has_many :slots, :through => :schedulings
  
  validates :title, :presence => true

end
