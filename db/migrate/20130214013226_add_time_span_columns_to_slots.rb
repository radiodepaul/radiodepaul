class AddTimeSpanColumnsToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :start_hour, :integer, default: 0, null: false
    add_column :slots, :start_min, :integer, default: 0, null: false
    add_column :slots, :end_hour, :integer, default: 0, null: false
    add_column :slots, :end_min, :integer, default: 0, null: false
  end

  def down
    remove_column :slots, :start_hour
    remove_column :slots, :start_min
    remove_column :slots, :end_hour
    remove_column :slots, :end_min
  end
end
