class AddColumnsToApplications < ActiveRecord::Migration
  def up
    add_column :applications, :why_listen, :text, :null => false, :default => ''
    add_column :applications, :why_work_here, :text, :null => false, :default => ''
  end
  def down
    remove_column :applications, :why_listen
    remove_column :applications, :why_work_here
  end
end
