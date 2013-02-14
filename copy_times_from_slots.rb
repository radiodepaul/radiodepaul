DAY_MAP = { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 0 }
DAYS    = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

Slot.all.each do |slot|
  days = []
  DAYS.each do |day|
    days.push(DAY_MAP[day]) if slot.send(day)
  end

  slot.days_array = days

  start_time = slot.start_time
  end_time   = slot.end_time

  hash = {}
  hash[:start_time] = { hour: start_time.hour, min: start_time.min }
  hash[:end_time]   = { hour: end_time.hour, min: end_time.min }

  slot.time_hash = hash
end
