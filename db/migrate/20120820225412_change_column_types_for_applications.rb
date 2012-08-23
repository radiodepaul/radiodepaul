class ChangeColumnTypesForApplications < ActiveRecord::Migration
  def up
    change_column :applications, :depaul_id, :string 
  end

  def down
    change_column :applications, :depaul_id, :integer
  end
end
