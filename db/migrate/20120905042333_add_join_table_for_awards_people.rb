class AddJoinTableForAwardsPeople < ActiveRecord::Migration
  def up
    create_table :awards_people, :id => false do |t|
      t.references :award, :null => false
      t.references :person, :null => false
    end

    # Adding the index can massively speed up join tables. Don't use the
    # unique if you allow duplicates.
    add_index(:awards_people, [:award_id, :person_id], :unique => true)
  end

  def down
    drop_table :awards_people
  end
end
