class Scheduling < ActiveRecord::Base
  belongs_to :show # foreign key - show_id
  belongs_to :slot # foreign key - slot_id

  def as_json(options={})
      {:show_title => self.show.title,
       :days_airing => self.slot.get_days_airing,
       :show_genre => self.show.genre,
       :show_short_description => self.show.short_description,
       :show_photo_thumb => self.show.avatar.thumb.url }
  end

end