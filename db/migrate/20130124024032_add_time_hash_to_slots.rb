class AddTimeHashToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :time_hash, :string, default: '{}'
  end

  def down
    remove_column :slots, :time_hash
  end
end
