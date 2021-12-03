# frozen_string_literal: true

Command = Struct.new(:direction, :amount)
Point = Struct.new(:x, :y, :aim) do
  def total
    x * y
  end
end

class DayTwo
  INPUT = File.join(File.dirname(__FILE__), '../inputs/two')

  def initialize(collector:)
    @collector = collector
  end

  def collect
    commands.each_with_object(Point.new(0, 0, 0), &collector)
  end

  private

  attr_reader :collector

  def commands
    @commands ||= File.read(INPUT).split("\n").reject(&:empty?).map do |command|
      command = command.split(' ')

      Command.new(command[0].to_sym, command[1].to_i)
    end
  end
end

puts "\nDay 2"
puts "├ Part one: #{DayTwo.new(collector: lambda do |command, point|
      case command.direction
      when :up then point.y -= command.amount
      when :down then point.y += command.amount
      when :forward then point.x += command.amount
      end
    end).collect.total}"

puts "└ Part two: #{DayTwo.new(collector: lambda do |command, point|
      case command.direction
      when :up then point.aim -= command.amount
      when :down then point.aim += command.amount
      when :forward
        point.x += command.amount
        point.y += point.aim * command.amount
      end
    end).collect.total}"
