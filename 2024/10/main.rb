#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
map = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [ci + 1i * ri, cell.to_i]
  end
end.to_h

# Try a depth first search first, because I know how to do those
trail_head_coords = map.select { _2.zero? }.map(&:first)
def walk(coords, map, next_level)
  new_coords = coords
               .product([-1, 1, 1i, -1i])
               .map { _1 + _2 }
               # Comment out the .uniq for part 2
               .uniq
               .map { [_1, map[_1]] }
               .select { _2 == next_level }

  if new_coords.empty? || next_level == 9
    new_coords.count
  else
    walk(new_coords.map(&:first), map, next_level + 1)
  end
end

pp trail_head_coords.sum { walk([_1], map, 1) }

# Part 1
part1 = nil

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
