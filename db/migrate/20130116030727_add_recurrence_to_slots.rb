class AddRecurrenceToSlots < ActiveRecord::Migration
  DAY_MAP = { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7 }
  DAYS    = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  def up
    add_column :slots, :recurrence, :text, default: '{}'

    copy_recurrence_from_days

    remove_column :slots, :monday
    remove_column :slots, :tuesday
    remove_column :slots, :wednesday
    remove_column :slots, :thursday
    remove_column :slots, :friday
    remove_column :slots, :saturday
    remove_column :slots, :sunday

  end

  def down
    remove_column :slots, :recurrence

    add_column :slots, :monday, :boolean
    add_column :slots, :tuesday, :boolean
    add_column :slots, :wednesday, :boolean
    add_column :slots, :thursday, :boolean
    add_column :slots, :friday, :boolean
    add_column :slots, :saturday, :boolean
    add_column :slots, :sunday, :boolean
  end

  def copy_recurrence_from_days
    Slot.all.each do |slot|
      days = []
      DAYS.each do |day|
        days.push(DAY_MAP[day]) if slot.send(day)
      end

      unless days.empty?
        rule = { start_date: Time.now,
                 rrules: [{validations: {day: days}, rule_type: 'IceCube::WeeklyRule', interval: 1 }],
                 exrules: [],
                 rtimes: [],
                 extimes: [] }

        slot.recurrence = IceCube::Schedule.from_hash(rule)
        slot.save
      end
    end
  end
end
