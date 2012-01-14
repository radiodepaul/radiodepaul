class Slot < ActiveRecord::Base
  has_many :shows, :through => :schedulings
  
  def quarter_start_time_end_time
    return self.quarter + ' between ' + self.start_time.strftime("%I:%M%p %Z") + ' and ' + self.end_time.strftime("%I:%M%p %Z")
  end
  
end
