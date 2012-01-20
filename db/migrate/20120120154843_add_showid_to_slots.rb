class AddShowidToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :show_id, :integer
  end
end