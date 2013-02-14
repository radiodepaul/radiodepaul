class TimeSpan
  attr_accessor :start_hour, :start_min, :end_hour, :end_min

  def initialize(start_hour, start_min, end_hour, end_min)
    @start_hour, @start_min = start_hour, start_min
    @end_hour, @end_min = end_hour, end_min
  end

  def include?(time)
    coerce(start_time) <= coerce(time) && coerce(time) < coerce(end_time)
  end

  def start_time
    @start_time ||= TimeObject.new(start_hour, start_min)
  end

  def end_time
    @end_time ||= TimeObject.new(end_hour, end_min)
  end

  private

  def coerce(time)
    time.strftime("%H:%M")
  end

  def to_s
    "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
  end

  class TimeObject
    attr_accessor :hour, :min

    def initialize(hour, min)
      @hour = hour
      @min  = min
    end

    def strftime(string)
      to_s
    end

    def to_s
      "#{format hour}:#{format min}"
    end

    private

    def format(time)
      sprintf '%02d', time
    end
  end
end
