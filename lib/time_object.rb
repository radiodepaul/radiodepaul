class TimeObject
  attr_accessor :hour, :min

  def initialize(hour, min)
    @hour = hour
    @min  = min
  end

  def strftime(string)
    "#{hour}:#{min}"
  end
end
