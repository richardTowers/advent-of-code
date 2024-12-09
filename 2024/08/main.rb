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

def find_antinodes(antenna_coords, &block)
  antenna_coords.values.flat_map do |coords|
    coords
      .product(coords)
      .reject { _1 == _2 }
      .map(&:to_set)
      .uniq
      .map(&:to_a)
      .flat_map { |first, second| block.call(first, second) }
  end.uniq
end

# Part 1
part1 = find_antinodes(antenna_coords) do |first, second|
  antenna_vector = second - first
  grid.key?(first - antenna_vector) || grid.key?(second + antenna_vector)
end.count

# Part 2
part2 = find_antinodes(antenna_coords) do |first, second|
  antenna_vector = second - first
  grid.keys.select do |coord|
    vector = second - coord
    harmonic = vector / antenna_vector
    harmonic.imag.zero?
  end
end.count

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
