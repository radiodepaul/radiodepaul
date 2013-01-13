class Position < ActiveRecord::Base
  attr_accessible :email, :office_hours, :phone, :title, :person_id

  belongs_to :person

  delegate :name, :first_name, :last_name, to: :person
end
