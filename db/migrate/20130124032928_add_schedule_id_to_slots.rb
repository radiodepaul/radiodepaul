class AddScheduleIdToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :schedule_id, :integer
  end
  def down
    remove_column :slots, :schedule_id
  end
end
