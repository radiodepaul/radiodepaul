class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :first_name
      t.string :last_name
      t.integer :depaul_id
      t.float :gpa
      t.string :year
      t.string :major
      t.string :email
      t.string :phone
      t.string :home_city
      t.string :home_state
      t.text :why_depaul
      t.text :influences
      t.text :bio
      t.string :position
      t.text :experience
      t.text :campus_involvement
      t.text :host_type
      t.string :co_hosts
      t.string :show_name
      t.text :show_description
      t.string :show_genres
      t.string :show_type
      t.string :podcast_topic
      t.text :favorite_artists
      t.text :favorite_tv_shows
      t.text :favorite_films
      t.text :famous_person
      t.text :anything_else

      t.timestamps
    end
  end
end
