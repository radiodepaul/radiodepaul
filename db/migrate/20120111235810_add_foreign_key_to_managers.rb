class AddForeignKeyToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :person_id, :integer
  end
end
