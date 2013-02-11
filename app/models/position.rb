class Position < ActiveRecord::Base
  attr_accessible :email, :office_hours, :person_id, :phone, :title
end
