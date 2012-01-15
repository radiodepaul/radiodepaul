class Scheduling < ActiveRecord::Base
  belongs_to :show # foreign key - show_id
  belongs_to :slot # foreign key - slot_id

end