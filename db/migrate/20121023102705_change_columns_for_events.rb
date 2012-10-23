class ChangeColumnsForEvents < ActiveRecord::Migration
  def up
    remove_column :events, :start
    remove_column :events, :end
    add_column :events, :first_line, :string
    add_column :events, :second_line, :string
  end

  def down
    remove_column :events, :first_line
    remove_column :events, :second_line
    add_column :events, :start, :datetime
    add_column :events, :end, :datetime

  end
end
