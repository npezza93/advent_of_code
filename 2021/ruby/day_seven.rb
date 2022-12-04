# frozen_string_literal: true

INPUT = File.join(File.dirname(__FILE__), '../inputs/seven')

def current_positions
  @current_positions ||= File.read(INPUT).strip.split(',').map(&:to_i)
end

def calculate(fuel_calculator)
  (current_positions.min...current_positions.max).
    min_by { |position| fuel_calculator.call(position) }.
    then { |economical_position| fuel_calculator.call(economical_position) }
end

def cost_of_gauss_fuel(position)
  current_positions.sum do |crab_position|
    (crab_position - position).abs.then do |movement|
      movement * (movement + 1) / 2
    end
  end
end

def cost_of_constant_fuel(position)
  current_positions.sum { |crab_position| (crab_position - position).abs }
end

puts "\nDay 7"
puts "├ Part one: #{calculate(method(:cost_of_constant_fuel))}"
puts "└ Part two: #{calculate(method(:cost_of_gauss_fuel))}"
