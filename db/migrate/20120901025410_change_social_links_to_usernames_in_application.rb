class ChangeSocialLinksToUsernamesInApplication < ActiveRecord::Migration
  def up
    rename_column :applications, :twitter_url, :twitter_username
    rename_column :applications, :facebook_url, :facebook_username
    rename_column :applications, :tumblr_url, :tumblr_username
  end
  def down
    rename_column :applications, :twitter_username, :twitter_url
    rename_column :applications, :facebook_username, :facebook_url
    rename_column :applications, :tumblr_username, :tumblr_url
  end
end
