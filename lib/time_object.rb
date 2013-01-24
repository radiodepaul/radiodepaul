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
