class UseArrayForDaysInSlots < ActiveRecord::Migration
  def up
    remove_column :slots, :schedule_hash
    add_column :slots, :days_array, :string, default: '[]'
  end

  def down
    add_column :slots, :schedule_hash, :text, default: '{}'
    remove_column :slots, :days_array
  end
end
