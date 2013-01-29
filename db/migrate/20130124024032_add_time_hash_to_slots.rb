class AddTimeHashToSlots < ActiveRecord::Migration
  def up
    add_column :slots, :time_hash, :string, default: '{}'
    Slot.all.each do |slot|
      slot.time_span = TimeSpan.new(TimeObject.new(12,0), TimeObject.new(13,0))
      slot.save!
    end
  end

  def down
    remove_column :slots, :time_hash
  end
end
