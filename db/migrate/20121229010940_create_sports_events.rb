class CreateSportsEvents < ActiveRecord::Migration
  def change
    create_table :sports_events do |t|
      t.string :quarter
      t.datetime :start_time
      t.datetime :end_time
      t.string :datetime
      t.text :description
      t.string :team
      t.string :opponent
      t.string :location

      t.timestamps
    end
  end
end
