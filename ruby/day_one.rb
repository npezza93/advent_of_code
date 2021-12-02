# frozen_string_literal: true

class DayOne
  INPUT = File.join(File.dirname(__FILE__), '../inputs/one')

  def initialize(part:, window:)
    @part = part
    @window = window
  end

  def collect
    increases = 0

    (measurements.size - window).times do |i|
      increases += 1 if window_sum(i) < window_sum(i + 1)
    end

    puts "Part #{part} increases: #{increases}"
  end

  private

  attr_reader :window, :part

  def measurements
    @measurements ||= File.read(INPUT).split("\n").reject(&:empty?)
  end

  def window_sum(index)
    measurements[index...(index + window)].map(&:to_i).sum
  end
end

puts "\n=== DAY ONE === \n"
DayOne.new(part: 'one', window: 1).collect
DayOne.new(part: 'two', window: 3).collect
