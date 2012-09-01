class ChangeUserIdToPersonIdInNewsPosts < ActiveRecord::Migration
  def up
    rename_column :news_posts, :user_id, :person_id
  end

  def down
    rename_column :news_posts, :person_id, :user_id
  end
end
