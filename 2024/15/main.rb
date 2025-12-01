#!/usr/bin/env ruby
# frozen_string_literal: true

def print_grid(grid)
  width = grid.keys.map(&:real).max
  height = grid.keys.map(&:imag).max

  (0..height).each do |ri|
    (0..width).each do |ci|
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

def find_boxes(map, dir, positions)
  new_positions = positions.select { map[_1 + dir] == 'O' }
  return [] if new_positions.empty?

  new_positions + find_boxes(map, dir, new_positions)
end

def move(map, dir)
  robot_position = map.find { _2 == '@' }.first
  case map[robot_position + dir]
  when '.'
    map[robot_position] = '.'
    map[robot_position + dir] = '@'
  when 'O'
    box_positions = find_boxes(map, dir, [robot_position])
    can_move = box_positions.none? { map[_1 + dir] == '#' }
    if can_move
      map[robot_position] = '.'
      box_positions.each do
        map[_1] = '.'
      end
      map[robot_position + dir] = '@'
      box_positions.each do
        map[_1 + dir] = 'O'
      end
    end
  end
end

# Part 1
moves.each { |m| print_grid(map); puts; move(map, m) }
part1 = map.select { _2 == 'O' }.sum { |coord, _| coord.real + 100 * coord.imag }

# Part 2

def do_part2(moves, map)
  part2_map = map.flat_map do |coord, cell|
    l = Complex.rect(2 * coord.real, coord.imag)
    r = l + 1
    case cell
    in '#' then [[l, '#'], [r, '#']]
    in 'O' then [[l, '['], [r, ']']]
    in '.' then [[l, '.'], [r, '.']]
    in '@' then [[l, '@'], [r, '.']]
    end
  end.to_h

  moves.each do |move|

  end
end

part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
