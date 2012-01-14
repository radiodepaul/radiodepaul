class CreateSchedulings < ActiveRecord::Migration
  def change
    create_table :schedulings do |t|
      t.integer :show_id
      t.integer :slot_id

      t.timestamps
    end
  end
end
