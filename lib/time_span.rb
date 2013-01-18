require 'active_support/core_ext/time/calculations'

class TimeSpan
  attr_accessor :start_time, :end_time

  def initialize(start_time, end_time)
    @start_time = start_time.change(year: 2000, month: 1, day: 1)
    @end_time   = end_time.change(year: 2000, month: 1, day: 1)
  end

  def cover?(time)
    if @start_time < @end_time
      (start_time..end_time).cover?(time.change(year: 2000, month: 1, day: 1))
    else
      !(start_time..end_time).cover?(time.change(year: 2000, month: 1, day: 1))
    end
  end
end
