class AddAvatarToShows < ActiveRecord::Migration
  def change
    add_column :shows, :avatar, :string
  end
end
