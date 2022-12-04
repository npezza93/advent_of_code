# frozen_string_literal: true

Point = Struct.new(:x, :y)

class Line
  def initialize(input)
    first, last = input.split('->')

    @first = Point.new(*first.strip.split(',').map(&:to_i))
    @last = Point.new(*last.strip.split(',').map(&:to_i))
  end

  def points
    @points ||=
      if horizontal?
        (initial_point.y..end_point.y).map { |y| Point.new(initial_point.x, y) }
      else
        (initial_point.x..end_point.x).flat_map.with_index do |x, i|
          Point.new(x, initial_point.y + (slope * i))
        end
      end
  end

  def diagonal?
    first.y != last.y && first.x != last.x
  end

  private

  def horizontal?
    first.x == last.x
  end

  def slope
    (first.y - last.y) / (first.x - last.x)
  end

  def initial_point
    [first, last].min_by { |p| [p.x, p.y] }
  end

  def end_point
    [first, last].max_by { |p| [p.x, p.y] }
  end

  attr_reader :first, :last
end

INPUT = File.join(File.dirname(__FILE__), '../inputs/five')

def lines
  @lines ||= File.read(INPUT).split("\n").map do |line|
    Line.new(line)
  end
end

def overlapping_points(lines)
  lines.flat_map(&:points).tally.count { |_k, v| v > 1 }
end

puts "\nDay 5"
puts "├ Part one: #{overlapping_points(lines.reject(&:diagonal?))}"
puts "└ Part two: #{overlapping_points(lines)}"
