class AddPriorityToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :priority, :boolean
  end
end