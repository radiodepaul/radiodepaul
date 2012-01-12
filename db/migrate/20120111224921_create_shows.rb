class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.string :genre
      t.string :short_description
      t.text :long_description
      t.string :facebook_page_username
      t.string :email
      t.string :twitter_username
      t.string :website_url

      t.timestamps
    end
  end
end
