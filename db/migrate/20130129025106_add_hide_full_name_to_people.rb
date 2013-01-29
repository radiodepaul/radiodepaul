class AddHideFullNameToPeople < ActiveRecord::Migration
  def up
    add_column :people, :hide_fullname, :boolean, default: false
  end
  def down
    remove_column :people, :hide_fullname
  end
end
