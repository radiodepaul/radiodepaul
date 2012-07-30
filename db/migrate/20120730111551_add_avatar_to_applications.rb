class AddAvatarToApplications < ActiveRecord::Migration
  def up
    add_column :applications, :avatar, :string
  end
  def down
    remove_column :applications, :avatar
  end
end
