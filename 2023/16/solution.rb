#!/usr/bin/env ruby

require "set"

LEFT = [-1, 0].freeze
UP = [0, -1].freeze
DOWN = [0, 1].freeze
RIGHT = [1, 0].freeze

Beam = Data.define(:position, :momentum) do
  def peek(grid)
    return nil if position.any?(&:negative?)

    grid.dig(position[1], position[0])
  end

  def move(grid)
    obstacle = peek(grid)
    momentums = case obstacle
                when "."
                  [momentum]
                when "/"
                  case momentum
                  when LEFT
                    [DOWN]
                  when UP
                    [RIGHT]
                  when DOWN
                    [LEFT]
                  when RIGHT
                    [UP]
                  end
                when "\\"
                  case momentum
                  when LEFT
                    [UP]
                  when UP
                    [LEFT]
                  when DOWN
                    [RIGHT]
                  when RIGHT
                    [DOWN]
                  end
                when "|"
                  case momentum
                  when LEFT, RIGHT
                    [UP, DOWN]
                  when UP, DOWN
                    [momentum]
                  end
                when "-"
                  case momentum
                  when LEFT, RIGHT
                    [momentum]
                  when UP, DOWN
                    [LEFT, RIGHT]
                  end
                when nil
                  []
                end
    momentums.map { |m| Beam.new(position.zip(m).map { _1 + _2 }, m) }.reject { _1.peek(grid).nil? }
  end
end

if __FILE__ == $PROGRAM_NAME
  grid = ARGF.readlines.map(&:strip).map { _1.split("").freeze }.freeze

  beams = [Beam.new(position: [0, 0], momentum: [1, 0])]
  visited = beams.to_set

  until beams.empty?
    beams = beams.flat_map { _1.move(grid) }.to_set
    beams -= visited
    visited |= beams
  end

  puts "Part 1: #{visited.map(&:position).to_set.length}"
end
