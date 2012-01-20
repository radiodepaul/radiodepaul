class AddContributorsToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :contributors, :string
  end
end