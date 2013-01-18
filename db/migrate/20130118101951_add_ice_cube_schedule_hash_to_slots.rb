require 'ice_cube'

class AddIceCubeScheduleHashToSlots < ActiveRecord::Migration
  include IceCube

  DAY_MAP = { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7 }
  DAYS    = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  def up
    add_column :slots, :schedule_hash, :text, default: '{}'

    copy_recurrence_from_days
  end

  def down
    remove_column :slots, :schedule_hash
  end

  def copy_recurrence_from_days
    Slot.all.each do |slot|
      days = []
      DAYS.each do |day|
        days.push(DAY_MAP[day]) if slot.send(day)
      end

      duration = slot.end_time - slot.start_time

      schedule = Schedule.new(slot.start_time, :duration => duration)

      schedule.add_recurrence_rule({validations: {day: days}, rule_type: 'IceCube::WeeklyRule', interval: 1})

      slot.schedule_hash = schedule.to_hash

      slot.save!
    end
  end
end
