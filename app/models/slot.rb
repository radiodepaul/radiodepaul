require 'json_tools'

class Slot < ActiveRecord::Base
  include JSONTools::JSONStore

  belongs_to :show
  belongs_to :schedule
  store :days_array

  validates :show_id, :presence => true

  composed_of :time_span, mapping: [%w(start_hour start_hour),
                                    %w(start_min start_min),
                                    %w(end_hour end_hour),
                                    %w(end_min end_min)]

  def self.on_air(time = Time.now)
    if override_enabled?
      override_show
    else
      on_air_slot(time) || default_slot
    end
  end

  def days
    self.days_array.map {|day| Date::DAYNAMES[day].downcase}
  end

  def self.active_schedule
    Settings.active_schedule
  end

  def start_time
    time_span.start_time.to_s
  end

  def end_time
    time_span.end_time.to_s
  end

  # Placed below in order to use self.active_schedule
  scope :active, where(quarter: active_schedule)
  scope :archived, where("quarter <> '#{active_schedule}'")

  private

  def self.on_air_slot(time = Time.now)
    Slot.active.find {|slot| slot.time_span.include?(time) && slot.days.include?(time.wday)}
  end

  def self.override_enabled?
    Settings.override
  end

  def self.default_slot
    new(show: hal_show,
        quarter: active_schedule,
        start_hour: Time.now.hour,
        start_min: 0,
        end_hour: 1.hour.from_now.hour,
        end_min: 0)
  end

  def self.hal_show
    Show.where('title like ?', 'HAL %').first
  end

  def self.override_show
    Slot.new(show: Show.find(Settings.override_show), quarter: active_schedule)
  end
end
