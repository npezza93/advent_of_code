# frozen_string_literal: true

class Lanterfish
  def initialize(days_until_birth)
    @days_until_birth = days_until_birth
  end

  attr_accessor :days_until_birth

  def new_day
    if days_until_birth.zero?
      self.days_until_birth = 6
      [self, Lanterfish.new(8)]
    else
      self.days_until_birth -= 1
      [self]
    end
  end
end

INPUT = File.join(File.dirname(__FILE__), '../inputs/six')

def initial_fish
  @initial_fish ||= File.read(INPUT).split(',').map do |days_until_birth|
    Lanterfish.new(days_until_birth.to_i)
  end
end

def after_x_days(days)
  fishes = [Lanterfish.new(3)]

  days.times do
    fishes = fishes.each_with_object([]) do |fish, school|
      school << fish.new_day
    end.flatten
  end

  fishes.count
end

puts "\nDay 6"
puts "├ Part one: #{after_x_days(80)}"
puts "└ Part two: #{after_x_days(256)}"
