class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.string :code
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
