class RemoveAuthorIdFromSlots < ActiveRecord::Migration
  def up
    remove_column :slots, :show_id
  end

  def down
    add_column :slots, :show_id, :integer
  end
end
