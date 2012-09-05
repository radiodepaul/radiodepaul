class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.string :for
      t.string :year

      t.timestamps
    end
  end
end
