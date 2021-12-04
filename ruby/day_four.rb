# frozen_string_literal: true

class Board
  def initialize(lines, callouts)
    @lines = lines.split("\n").map do |line|
      line.split(/\s+/).reject(&:empty?).map(&:to_i)
    end
    @callouts = callouts
  end

  def bingo_index
    @bingo_index ||=
      (lines + lines.transpose).map do |line|
        callouts.find_index.with_index do |number, index|
          (line - callouts[0..index]).empty?
        end
      end.min
  end

  def unmarked_numbers
    lines.flatten - callouts[0..bingo_index]
  end

  def bingo_number
    callouts[bingo_index]
  end

  def score
    unmarked_numbers.sum * bingo_number
  end

  private

  attr_reader :lines, :callouts
end

INPUT = File.join(File.dirname(__FILE__), '../inputs/four')

def callouts
  @callouts ||= File.read(INPUT).split("\n\n")[0].split(",").map(&:to_i)
end

def boards
  @boards ||= File.read(INPUT).split("\n\n")[1..].map do |lines|
    Board.new(lines, callouts)
  end
end

puts "\nDay 4"
puts "├ Part one: #{boards.min_by(&:bingo_index).score}"
puts "└ Part two: #{boards.max_by(&:bingo_index).score}"
