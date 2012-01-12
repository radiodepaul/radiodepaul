class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.text :bio
      t.text :influences
      t.string :facebook_username
      t.string :linkedin_username
      t.string :twitter_username
      t.string :website_url
      t.string :email
      t.string :major
      t.string :class_year
      t.string :hometown

      t.timestamps
    end
  end
end
