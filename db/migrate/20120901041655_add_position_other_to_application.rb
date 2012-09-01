class AddPositionOtherToApplication < ActiveRecord::Migration
  def up
    add_column :applications, :position_other, :string, :null => false, :default => ''
  end
  def down
    remove_column :applications, :position_other
  end
end
