# frozen_string_literal: true

class DayThree
  INPUT = File.join(File.dirname(__FILE__), '../inputs/three')

  def power_consumption
    gamma.join.to_i(2) * gamma.map { |bit| bit ^ 1 }.join.to_i(2)
  end

  def life_support_rating
    rating(diagnostics, 0, 0) * rating(diagnostics, 0, 1)
  end

  private

  def diagnostics
    @diagnostics ||= File.read(INPUT).split("\n").reject(&:empty?).map do |command|
      command.split('').map(&:to_i)
    end
  end

  def to_i(bit)
    bit ? 1 : 0
  end

  def rating(lines, index, common)
    return lines.first.join.to_i(2) if lines.size == 1

    tally = lines.map { |bits| bits[index] }.tally

    bit = to_i(tally[1] >= tally[0]) ^ common

    rating(lines.select { |bits| bits[index] == bit }, index + 1, common)
  end

  def gamma
    @gamma ||= diagnostics.transpose.map(&:tally).map do |counts|
      counts.max_by { |_k, v| v }[0]
    end
  end
end

day_three = DayThree.new
puts "\nDay 3"
puts "├ Part one: #{day_three.power_consumption}"
puts "└ Part two: #{day_three.life_support_rating}"
