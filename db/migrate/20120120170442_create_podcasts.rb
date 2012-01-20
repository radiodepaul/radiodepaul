class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.string :podcast_type
      t.string :contributors
      t.string :file

      t.timestamps
    end
  end
end
