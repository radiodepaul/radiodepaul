class AddAwardOrganizationToAwards < ActiveRecord::Migration
  def up
    add_column :awards, :award_organization_id, :integer
  end
  def down
    remove_column :awards, :award_organization_id
  end
end
