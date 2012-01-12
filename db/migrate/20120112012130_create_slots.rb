class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :show_id
      t.string :quarter
      t.time :start_time
      t.time :end_time
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday

      t.timestamps
    end
  end
end
