DAY_MAP = { sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6}

Slot.all.each do |slot|
  days = []
  [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
    days.push(DAY_MAP[day]) if slot.send(day)
  end

  unless days.empty?
    rule = { start_date: Time.now, rrules: [{validations: {day: days}, rule_type: 'IceCube::WeeklyRule', interval: 1 }], exrules: [], rtimes: [], extimes: [] }

    slot.recurrence = IceCube::Schedule.from_hash(rule)
    slot.save
  end
end
