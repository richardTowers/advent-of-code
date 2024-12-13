#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
grid = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [ci + 1i * ri, cell]
  end
end.to_h

def flood_fill(grid)
  queue = []
  visited = Set[]
  regions = []
  until (coord = grid.keys.find { !visited.include?(_1) }).nil?
    queue << coord
    current_cell = grid[coord]
    region = []
    until queue.empty?
      candidate = queue.shift
      next unless grid[candidate] == current_cell

      region << candidate
      visited << candidate
      [1, -1, 1i, -1i]
        .map { candidate + _1 }
        .select { grid.key?(_1) && !(visited.include?(_1) || queue.include?(_1)) }
        .each { queue << _1 }
    end
    regions << region
  end
  regions
end

regions = flood_fill(grid)

# Part 1
part1 = regions.sum do |coords|
  area = coords.count
  perimeter = coords.product([1, -1, 1i, -1i]).reject { coords.include?(_1 + _2) }
  area * perimeter.count
end

# Part 2
part2 = regions.sum do |coords|
  area = coords.count
  perimeter = coords.product([1, -1, 1i, -1i]).reject { coords.include?(_1 + _2) }
  # Credit to /u/4HbQ for this trick - https://www.reddit.com/r/adventofcode/comments/1hcdnk0/comment/m1nj6se/
  # which I don't fully understand :|
  edges = perimeter - perimeter.map { |coord, dir| [coord + dir * 1i, dir] }
  area * edges.count
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"

