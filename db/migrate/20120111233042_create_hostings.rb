class CreateHostings < ActiveRecord::Migration
  def change
    create_table :hostings do |t|
      t.integer :show_id
      t.integer :person_id

      t.timestamps
    end
  end
end
