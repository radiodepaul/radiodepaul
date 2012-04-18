class ChangeAuthorIdToUserIdInPosts < ActiveRecord::Migration
  def up
  	remove_column :news_posts, :author_id
  	add_column :news_posts, :user_id, :string

  end

  def down
  	remove_column :news_posts, :user_id
  	add_column :news_posts, :author_id, :string
  	
  end
end
