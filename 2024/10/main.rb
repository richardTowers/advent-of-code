#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
map = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [ci + 1i * ri, cell.to_i]
  end
end.to_h

# Part 1
def walk(coords, map, next_level, &block)
  new_coords = block.call(coords.product([-1, 1, 1i, -1i]).map(&:sum).select { map[_1] == next_level })
  return new_coords.count if new_coords.empty? || next_level == 9

  walk(new_coords, map, next_level + 1, &block)
end

trail_head_coords = map.select { _2.zero? }.map(&:first)

part1 = trail_head_coords.sum { |coord| walk([coord], map, 1, &:uniq) }

# Part 2
part2 = trail_head_coords.sum { |coord| walk([coord], map, 1, &:itself) }

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
