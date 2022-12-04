# frozen_string_literal: true

INPUT = File.join(File.dirname(__FILE__), '../inputs/nine')

def points
  @points ||= File.read(INPUT).strip.split("\n").map { |line| line.split('').map(&:to_i) }
end

def low_point?(point, x, y)
  [points[y][x + 1], points[y][x - 1], points[y + 1]&.[](x), points[y - 1]&.[](x)].
    compact.min > point
end

low_points = points.map.with_index do |row, y|
  row.select.with_index do |point, x|
    point if low_point?(point, x, y)
  end
end.flatten

puts "\nDay 9"
puts "├ Part one: #{low_points.sum { |height| height + 1 }}"
# puts "└ Part two: #{calculate(method(:cost_of_gauss_fuel))}"
