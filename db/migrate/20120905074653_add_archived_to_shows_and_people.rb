class AddArchivedToShowsAndPeople < ActiveRecord::Migration
  def up
    add_column :shows, :archived, :boolean, :default => false
    add_column :people, :archived, :boolean, :default => false
  end
  def down
    remove_column :shows, :archived
    remove_column :people, :archived
  end
end
