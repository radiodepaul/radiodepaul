class CopyTimeToTimeHash < ActiveRecord::Migration
  DAY_MAP = { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 0 }
  DAYS    = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  def up
    copy_schedule

    remove_column :slots, :start_time
    remove_column :slots, :end_time
    remove_column :slots, :monday
    remove_column :slots, :tuesday
    remove_column :slots, :wednesday
    remove_column :slots, :thursday
    remove_column :slots, :friday
    remove_column :slots, :saturday
    remove_column :slots, :sunday
  end

  def down
    add_column :slots, :start_time, :datetime
    add_column :slots, :end_time, :datetime
    add_column :slots, :monday, :boolean
    add_column :slots, :tuesday, :boolean
    add_column :slots, :wednesday, :boolean
    add_column :slots, :thursday, :boolean
    add_column :slots, :friday, :boolean
    add_column :slots, :saturday, :boolean
    add_column :slots, :sunday, :boolean
  end

  def copy_schedule
    Slot.all.each do |slot|
      copy_days_to_days_array(slot)
      copy_times_to_time_hash(slot)

      slot.save!
    end
  end

  def copy_days_to_days_array(slot)
    days = []
    DAYS.each do |day|
      days.push(DAY_MAP[day]) if slot.send(day)
    end

    slot.days_array = days
  end

  def copy_times_to_time_hash(slot)
    start_time = slot.start_time
    end_time   = slot.end_time

    hash = {}
    hash[:start_time] = { hour: start_time.hour, min: start_time.min }
    hash[:end_time]   = { hour: end_time.hour, min: end_time.min }

    slot.time_hash = hash
  end
end
