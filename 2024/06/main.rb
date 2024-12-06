#!/usr/bin/env ruby
# frozen_string_literal: true

# Definitions
class Grid
  attr_reader :cells, :position, :direction, :visited_positions, :visited_states

  def initialize(cells)
    @cells = cells
    @direction = -1i
    @position = cells.find { |_, cell| cell == '^' }.first
    @visited_positions = Set[@position]
    @visited_states = Set[[@position, @direction]]
  end

  def move_to(candidate_position)
    @position = candidate_position
    @visited_positions << @position
    @visited_states << [@position, @direction]
    'moved'
  end

  def turn_right
    @direction *= 1i
    'turned'
  end

  def move
    candidate_position = position + direction
    return 'loop' if visited_states.include? [candidate_position, direction]

    case cells[candidate_position]
    in '^' then move_to(candidate_position)
    in '.' then move_to(candidate_position)
    in '#' then turn_right
    in nil then 'outside_grid'
    end
  end
end

# Parse input
lines = ARGF.readlines
cells = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [(ci + 1i * ri), cell]
  end
end.to_h

# Part 1
grid = Grid.new(cells)
nil until %w[loop outside_grid].include?(grid.move)
part1 = grid.visited_positions.count

# Part 2
part2 = grid.visited_positions.drop(1).count do |pos|
  modified_grid = Grid.new(cells.merge({ pos => '#' }))
  nil until %w[loop outside_grid].include?((state = modified_grid.move))
  state == 'loop'
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
