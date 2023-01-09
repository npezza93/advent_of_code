# frozen_string_literal: true

module Outcome
  def inspect
    self.class.name.downcase
  end

  def defeated_by?(shape)
    shape.is_a?(defeator.class)
  end

  def defeats?(shape)
    shape.defeated_by?(self)
  end

  def <=>(shape)
    if defeats?(shape)
      6
    elsif defeated_by?(shape)
      0
    else
      3
    end
  end
end

class Rock
  include Outcome

  def score
    1
  end

  def defeator
    Paper.new
  end
end

class Paper
  include Outcome

  def score
    2
  end

  def defeator
    Scissors.new
  end
end

class Scissors
  include Outcome

  def score
    3
  end

  def defeator
    Rock.new
  end
end

class Round
  def initialize(expected, suggestion, suggestion_shapes)
    @expected = shapes[expected]
    @suggestion = suggestion_shapes[suggestion]
  end

  def outcome
    (suggestion <=> expected) + suggestion.score
  end

  attr_reader :expected, :suggestion

  private

  def shapes
    { "A" => Rock.new, "B" => Paper.new, "C" => Scissors.new }
  end
end

class DayTwo
  INPUT = File.join(File.dirname(__FILE__), 'inputs/2')

  def shape_suggestion
    shapes = { "X" => Rock.new, "Y" => Paper.new, "Z" => Scissors.new }

    rounds(shapes).sum(&:outcome)
  end

  def outcome_suggestion
    shapes = { "X" => Rock.new, "Y" => Paper.new, "Z" => Scissors.new }

    rounds(shapes).sum(&:outcome)
  end

  def rounds(shapes)
    File.read(INPUT).each_line.map do |round|
      Round.new(*round.split(" "), shapes)
    end
  end
end


puts "\nDay 2"
puts "├ Part one: #{DayTwo.new.shape_suggestion}"
puts "└ Part two: #{DayOne.new.outcome_suggestion}"
