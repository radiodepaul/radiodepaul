class RemoveTimeHashFromSlots < ActiveRecord::Migration
  def up
    remove_column :slots, :time_hash
  end

  def down
    add_column :slots, :time_hash, :string, default: '{}'
  end
end
