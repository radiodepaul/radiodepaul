class Slot < ActiveRecord::Base
  belongs_to :show
  
  validates :quarter, :presence => true 
  validates :show_id, :presence => true

  scope :active, where(quarter: Settings.active_schedule)

  def time
    "#{start_time} - #{end_time}"
  end
  
  def days
    days = []
    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
      days.push(day.to_s) if send(day)
    end

    days
  end

  def self.on_air
    return Slot.new(show: Show.find(Settings.override_show), 
                    quarter: Settings.active_schedule) if Settings.override

    hal = Show.where('title like ?', 'HAL %').first
    default = new(show: hal, quarter: Settings.active_schedule)

    current_day = Time.now.strftime('%A').downcase!
    find(:all, :conditions => ['quarter = ? AND start_time <= ? AND end_time >=  ? AND ' + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now]).first || default
  end
  
  def as_json(options={})
    options[:include] ||= [:show]
    options[:methods] ||= [:days, :time]

    super(options)
  end
end
