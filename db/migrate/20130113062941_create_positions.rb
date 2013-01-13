class CreatePositions < ActiveRecord::Migration
  def up
    create_table :positions do |t|
      t.string :title
      t.string :email
      t.string :phone
      t.text :office_hours
      t.integer :person_id

      t.timestamps
    end
  end
  def down
    drop_table :positions
  end
end
