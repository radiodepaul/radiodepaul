require 'json_tools'

class Slot < ActiveRecord::Base
  include JSONTools::JSONStore

  belongs_to :show
  belongs_to :schedule

  validates :quarter, :presence => true
  validates :show_id, :presence => true

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
    Slot.active.find {|slot| slot.time_span.cover?(time) }
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
