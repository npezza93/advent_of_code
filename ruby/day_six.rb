# frozen_string_literal: true

INPUT = File.join(File.dirname(__FILE__), '../inputs/six')

def initial_fish
  File.read(INPUT).strip.split(',').map(&:to_i).tally
end

def after_x_days(days)
  school = initial_fish

  days.times do
    school = school.to_h { |remaining, count| [remaining - 1, count] }
    school.default = 0

    school[8], school[6] = school[-1], school[6] + school[-1]

    school.delete(-1)
  end

  school.values.sum
end

puts "\nDay 6"
puts "├ Part one: #{after_x_days(80)}"
puts "└ Part two: #{after_x_days(256)}"
