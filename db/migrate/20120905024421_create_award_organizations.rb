class CreateAwardOrganizations < ActiveRecord::Migration
  def change
    create_table :award_organizations do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
