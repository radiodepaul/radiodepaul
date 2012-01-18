class Hosting < ActiveRecord::Base
  belongs_to :show # foreign key - show_id
  belongs_to :person # foreign key - person_id

  validates :show_id, :presence => true
  validates :person_id, :presence => true

end
