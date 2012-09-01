class AddColumnsToPeople < ActiveRecord::Migration
  def up
    add_column :people, :tumblr_username, :string
    add_column :people, :phone, :string
    add_column :people, :favorite_artists, :text
    add_column :people, :favorite_films, :text
    add_column :people, :favorite_tv_shows, :text
  end
  def down
    remove_column :people, :tumblr_username
    remove_column :people, :phone
    remove_column :people, :favorite_artists
    remove_column :people, :favorite_films
    remove_column :people, :favorite_tv_shows
  end
end
