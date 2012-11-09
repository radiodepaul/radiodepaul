class Slot < ActiveRecord::Base
  belongs_to :show
  
  def quarter_start_time_end_time
    return self.quarter + ' between ' + self.start_time.strftime("%I:%M%p %Z") + ' and ' + self.end_time.strftime("%I:%M%p %Z") + " on " + get_days_airing_s
  end
  
  def time_days
    return get_days_airing_s + ' ' + self.start_time.strftime("%I:%M%p %Z") + ' - ' + self.end_time.strftime("%I:%M%p %Z")
  end
  
  validates :quarter, :presence => true 
  validates :show_id, :presence => true
  
  def get_days_airing
    days_airing = Array.new
      if self.monday == true
        days_airing.push "monday"
      end
      if self.tuesday == true
        days_airing.push "tuesday"
      end
      if self.wednesday == true
        days_airing.push "wednesday"
      end
      if self.thursday == true
        days_airing.push "thursday"
      end
      if self.friday == true
        days_airing.push "friday"
      end
      if self.saturday == true
        days_airing.push "saturday"
      end
      if self.sunday == true
        days_airing.push "sunday"
      end
    return days_airing
  end
  
  def get_days_airing_s
    days_airing = Array.new
      if self.monday == true
        days_airing.push "Mondays"
      end
      if self.tuesday == true
        days_airing.push "Tuesdays"
      end
      if self.wednesday == true
        days_airing.push "Wednesdays"
      end
      if self.thursday == true
        days_airing.push "Thursdays"
      end
      if self.friday == true
        days_airing.push "Fridays"
      end
      if self.saturday == true
        days_airing.push "Saturdays"
      end
      if self.sunday == true
        days_airing.push "Sundays"
      end
      days_airing_s = ""
      days_airing.each do |d|
        unless d == days_airing.last then
          days_airing_s += d + ", "
        else
          days_airing_s += d
        end
      end
    return days_airing_s
  end
  
  def get_hosts 
    hosts = Array.new
    self.show.people.each do |person|
      hosts.push name: person.first_last_name,
        id: person.id,
        bio: person.bio || '',
        influences: person.influences || '',
        photo_thumb: person.avatar.square.thumb.url,
        photo_small: person.avatar.square.small.url,
        photo_medium: person.avatar.square.medium.url,
        photo_large: person.avatar.square.large.url,
        show_url: "http://radio.depaul.edu/person?id=#{person.id}"
    end
    return hosts
  end
  
  def as_json(options={})
      {
         quarter: self.quarter,
         days: get_days_airing,
         start_time: self.start_time.strftime("%I:%M%p %Z"),
         end_time: self.end_time.strftime("%I:%M%p %Z"),
         show: { title: self.show.title,
                 scheduled_at: self.show.get_scheduled_slots,
                 id: self.show.id,
                 hosts: get_hosts,
                 genre: self.show.genre_list,
                 show_url: "http://radio.depaul.edu/show?id=#{self.show.id}",
                 short_description: self.show.short_description,
                 long_description: self.show.long_description,
                 photo: self.show.avatar.square.small.url,
                 photo_thumb: self.show.avatar.square.thumb.url,
                 photo_small: self.show.avatar.square.small.url,
                 photo_medium: self.show.avatar.square.medium.url,
                 photo_large: self.show.avatar.square.large.url
              }
      }
  end
  
end
