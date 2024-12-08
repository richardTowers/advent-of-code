#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
grid = ARGF.readlines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index { |cell, ci| [ci + 1i * ri, cell] }
end.to_h

antenna_coords = grid
                 .reject { _2 == '.' }
                 .group_by { _2 }
                 .transform_values { _1.map(&:first) }

antinodes = antenna_coords.transform_values do |coords|
  coords
    .product(coords)
    .reject { _1 == _2 }
    .map(&:to_set)
    .uniq
    .map(&:to_a)
    .flat_map do
      vector = _2 - _1
      [_1 - vector, _2 + vector]
    end.select { grid.key?(_1) }
end

# Part 1
part1 = antinodes.values.flatten.uniq.count

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
