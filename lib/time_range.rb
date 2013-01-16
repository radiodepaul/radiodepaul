class TimeRange
  attr_accessor :start_time, :end_time

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time   = end_time
  end

  def cover?(time)
    cover_hours?(time) && cover_minutes?(time)
  end

  def cover_hours?(time)
    @start_time.hour <= time.hour && time.hour <= @end_time.hour
  end

  def cover_minutes?(time)
    @start_time.min <= time.min && time.min <= @end_time.min
  end
end
