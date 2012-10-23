class Event < ActiveRecord::Base
  attr_accessible :description, :location, :title, :first_line, :second_line
end
