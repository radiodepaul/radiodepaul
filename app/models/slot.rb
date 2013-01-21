require 'ice_cube'
require 'json_tools'

class Slot < ActiveRecord::Base
  include JSONTools::JSONStore, IceCube

  store :schedule_hash
  belongs_to :show

  validates :quarter, :presence => true
  validates :show_id, :presence => true

  def schedule
    Schedule.from_hash(self.schedule_hash)
  end

  delegate :occurs_at?, :start_time, :end_time, :duration, to: :schedule

  def schedule=(new_schedule)
    self.schedule_hash = new_schedule.to_hash
  end

  def occurences
    schedule.all_occurences
  end

  def self.on_air(time = Time.now)
    if override_enabled?
      override_show
    else
      on_air_slot(time) || default_slot
    end
  end

  def self.active_schedule
    Settings.active_schedule
  end

  def time_span
    TimeSpan.new(start_time, end_time)
  end

  # Placed below in order to use self.active_schedule
  scope :active, where(quarter: active_schedule)
  scope :archived, where("quarter <> '#{active_schedule}'")

  private

  def self.on_air_slot(time)
    Slot.active.find {|slot| slot.time_span.cover?(time)  && slot.occurs_at?(time) }
  end

  def self.override_enabled?
    Settings.override
  end

  def self.default_slot
    new(show: hal_show, quarter: active_schedule)
  end

  def self.hal_show
    Show.where('title like ?', 'HAL %').first
  end

  def self.override_show
    Slot.new(show: Show.find(Settings.override_show), quarter: active_schedule)
  end
end
