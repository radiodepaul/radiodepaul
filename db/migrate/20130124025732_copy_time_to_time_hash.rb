class CopyTimeToTimeHash < ActiveRecord::Migration
  def up
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
end
