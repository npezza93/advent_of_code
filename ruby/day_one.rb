# frozen_string_literal: true

class DayOne
  INPUT = File.join(File.dirname(__FILE__), '../inputs/one')

  def initialize(window:)
    @window = window
  end

  def collect
    increases = 0

    (measurements.size - window).times do |i|
      increases += 1 if window_sum(i) < window_sum(i + 1)
    end

    increases
  end

  private

  attr_reader :window

  def measurements
    @measurements ||= File.read(INPUT).split("\n").reject(&:empty?)
  end

  def window_sum(index)
    measurements[index...(index + window)].map(&:to_i).sum
  end
end

puts "\nDay 1"
puts "├ Part one: #{DayOne.new(window: 1).collect}"
puts "└ Part two: #{DayOne.new(window: 3).collect}"
