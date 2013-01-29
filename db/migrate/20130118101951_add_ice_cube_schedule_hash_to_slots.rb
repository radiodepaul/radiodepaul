class AddIceCubeScheduleHashToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :schedule_hash, :text, default: '{}'
  end

  def down
    remove_column :slots, :schedule_hash
  end
end
