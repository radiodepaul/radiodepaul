require 'time_span'

describe TimeSpan do
  describe '#cover?' do
    let(:seven_o_clock) { Time.new(2008, 1, 1, 7,0,0, '-06:00') }
    let(:nine_o_clock)  { Time.new(2008, 1, 1, 9,0,0, '-06:00') }

    it 'returns true when the hour is between the hours of the TimeSpan' do
      seven_o_clock = Time.new(2008, 1, 1, 7,0,0, '-06:00')

      time_span = TimeSpan.new(seven_o_clock, nine_o_clock)

      time_span.cover?(seven_o_clock).should be_true
    end

    it 'returns false when the hour is not between the hours of the TimeSpan' do
      two_o_clock = Time.new(2008, 1, 1, 2,0,0, '-06:00')

      time_span = TimeSpan.new(seven_o_clock, nine_o_clock)

      time_span.cover?(two_o_clock).should be_false
    end

    it 'returns true when the minute is between the hours of the TimeSpan' do
      time1 = Time.new(2008, 1, 1, 2,1,0, '-06:00')
      time2 = Time.new(2008, 1, 1, 4,3,0, '-06:00')
      time3 = Time.new(2008, 1, 1, 3,5,0, '-06:00')

      time_span = TimeSpan.new(time1, time2)

      time_span.cover?(time3).should be_true
    end

    it 'should not care about times on different days' do
      day = Time.new(2008, 2, 1, 7,0,0, '-06:00')
      another_day = Time.new(2008, 1, 1, 9,0,0, '-06:00')
      between = Time.new(2008, 1, 1, 8,0,0, '-06:00')
      not_between = Time.new(2008, 1, 1, 6,0,0, '-06:00')

      time_span = TimeSpan.new(day, another_day)

      time_span.cover?(between).should be_true
      time_span.cover?(not_between).should be_false
    end

    it 'handles timespans that cross midnight' do
      before_midnight = Time.new(2008, 1, 1, 23,0,0, '-06:00')
      between = Time.new(2008, 1, 1, 22,00,0, '-06:00')
      after_midnight = Time.new(2008, 1, 1, 1,0,0, '-06:00')

      time_span = TimeSpan.new(before_midnight, after_midnight)

      time_span.cover?(between).should be_true
    end
  end
end
