class ChangeHostingsToPeopleShows < ActiveRecord::Migration
  def up
    rename_table :hostings, :people_shows
  end

  def down
    rename_table :people_shows, :hostings
  end
end
