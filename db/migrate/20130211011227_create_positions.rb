class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.string :email
      t.string :phone
      t.text :office_hours
      t.integer :person_id

      t.timestamps
    end
  end
end
