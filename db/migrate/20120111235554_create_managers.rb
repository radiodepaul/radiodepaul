class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.string :position
      t.text :office_hours
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
