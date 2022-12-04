# frozen_string_literal: true

class Elf
  def initialize(calories)
    @calories = calories.split("\n").map(&:to_i)
  end

  attr_reader :calories

  def total
    @total ||= calories.sum
  end
end

class DayOne
  INPUT = File.join(File.dirname(__FILE__), 'inputs/1')

  def initialize(limit)
    @limit = limit
  end

  def max_calories
    elves.sort_by(&:total).last(limit).sum(&:total)
  end

  private

  attr_reader :limit

  def elves
    @elves ||= File.read(INPUT).split("\n\n").map do |elf|
      Elf.new(elf)
    end
  end
end

puts "\nDay 1"
puts "├ Part one: #{DayOne.new(1).max_calories}"
puts "└ Part two: #{DayOne.new(3).max_calories}"
