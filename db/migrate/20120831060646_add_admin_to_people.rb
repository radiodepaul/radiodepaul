class AddAdminToPeople < ActiveRecord::Migration
  def up
    add_column :people, :admin, :boolean, :null => false, :default => false
  end
  def down
    remove_column :people, :admin
  end
end
