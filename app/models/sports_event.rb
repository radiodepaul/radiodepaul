class SportsEvent < ActiveRecord::Base
  attr_accessible :datetime, :description, :end_time, :location, :opponent, :quarter, :start_time, :team
end
