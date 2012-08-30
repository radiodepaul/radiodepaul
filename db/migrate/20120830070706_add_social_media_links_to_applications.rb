class AddSocialMediaLinksToApplications < ActiveRecord::Migration
  def up
    add_column :applications, :twitter_url, :string
    add_column :applications, :facebook_url, :string
    add_column :applications, :tumblr_url, :string
  end

  def down
    remove_column :applications, :twitter_url
    remove_column :applications, :facebook_url
    remove_column :applications, :tumblr_url
  end
end
