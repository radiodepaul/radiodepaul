require 'active_support/core_ext/hash/indifferent_access'

class TimeSpan
  attr_accessor :start_time, :end_time

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time   = end_time
  end

  def include?(time)
    coerce(start_time) <= coerce(time) && coerce(time) < coerce(end_time)
  end

  def to_hash
    { start_time: { hour: start_time.hour, min: start_time.min },
      end_time:   { hour: end_time.hour,   min: end_time.min   } }
  end

  def self.from_hash(hash)
    hash = hash.with_indifferent_access
    start_time = TimeObject.new(hash[:start_time][:hour], hash[:start_time][:min])
    end_time   = TimeObject.new(hash[:end_time][:hour], hash[:end_time][:min])
    self.new(start_time, end_time)
  end

  private

  def coerce(time)
    time.strftime("%H:%M")
  end
end
