class Person < ActiveRecord::Base
has_many :hostings
has_many :shows, :through => :hostings
belongs_to :manager

def first_last_name
  return self.first_name + ' ' + self.last_name
end

def last_first_name
  return self.last_name + ', ' + self.first_name
end

validates :first_name, :presence => true
validates :last_name, :presence => true

end
