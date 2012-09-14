class AddAdminBooleanValuesToApplications < ActiveRecord::Migration
  def up
    add_column :applications, :archived, :boolean, :default => false
    add_column :applications, :hired, :boolean, :default => false
    add_column :applications, :rejected, :boolean, :default => false
  end
  def down
    remove_column :applications, :archived
    remove_column :applications, :hired
    remove_column :applications, :rejected
  end
end
