class Setting < ActiveRecord::Base
  attr_accessible :value, :var
  validates :var, :presence => true
end
