#!/usr/bin/env ruby
# frozen_string_literal: true

def print_grid(grid)
  width = grid.keys.map(&:real).max
  height = grid.keys.map(&:imag).max

  (0..height).each do |ci|
    (0..width).each do |ri|
      print grid[ri + 1i * ci]
    end
    print "\n"
  end
end

# Parse input
input = ARGF.read
map_input, moves_input = input.split("\n\n")
map = map_input.split("\n").flat_map.with_index do |row, ri|
  row.split('').map.with_index do |cell, ci|
    [ci + 1i * ri, cell]
  end
end.to_h
moves = moves_input.split('').map do |char|
  case char
  in "\n" then nil
  in '^' then -1i
  in '>' then 1
  in 'v' then 1i
  in '<' then -1
  end
end.compact

moves.each do |move|
  robot_position = map.find { _2 == '@' }.first
  box_positions = (1..).lazy
                       .map { robot_position + _1 * move }
                       .take_while { map[_1] == 'O' }
                       .to_a
  next_position = robot_position + (box_positions.length + 1) * move
  case map[next_position]
  in '#'
    # Do nothing
  in '.'
    map[robot_position] = '.'
    map[next_position] = 'O'
    map[robot_position + move] = '@'
  end

  # puts
  # puts "Move #{move}:"
  # print_grid(map)
end

# Part 1
part1 = map.select { _2 == 'O' }.sum { |coord, _| coord.real + 100 * coord.imag }

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
