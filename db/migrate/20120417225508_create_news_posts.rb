class CreateNewsPosts < ActiveRecord::Migration
  def change
    create_table :news_posts do |t|
      t.string :headline
      t.datetime :datetime_published
      t.text :content
      t.string :author_id

      t.timestamps
    end
  end
end
