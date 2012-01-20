class AddDepaulIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :depaul_id, :string
  end
end
