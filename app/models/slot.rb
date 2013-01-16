require 'ice_cube'

class Slot < ActiveRecord::Base
  include JSONTools::JSONStore, IceCube

  attr_protected :recurrence

  store :recurrence
  belongs_to :show

  scope :active, where(quarter: Settings.active_schedule)
  scope :archived, where("quarter <> '#{Settings.active_schedule}'")

  validates :quarter, :presence => true
  validates :show_id, :presence => true

  def days
    days = []
    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
      days.push(day.to_s) if send(day)
    end

    days
  end

  def schedule
    Schedule.from_hash(self.recurrence)
  end

  def schedule=(new_schedule)
    self.recurrence = new_schedule.to_hash
  end

  def self.on_air
    return Slot.new(show: Show.find(Settings.override_show),
                    quarter: Settings.active_schedule) if Settings.override

    hal = Show.where('title like ?', 'HAL %').first
    default = new(show: hal, quarter: Settings.active_schedule)

    current_day = Time.now.strftime('%A').downcase!
    active.find(:all, :conditions => ['quarter = ? AND start_time <= ? AND end_time >=  ? AND ' + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now]).first || default
  end
end
