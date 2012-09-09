class RemoveGenreColumnFromShows < ActiveRecord::Migration
  def up
    remove_column :shows, :genre
  end

  def down
    add_column :shows, :genre, :string
  end
end
