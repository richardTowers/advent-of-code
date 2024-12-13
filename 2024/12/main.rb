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
  regions = Hash.new { [] }
  region_id = 0
  until (node = grid.find { |node| !visited.include?(node) }).nil?
    queue << node
    plant_type = node[1]
    region = []
    until queue.empty?
      node = queue.shift
      next unless node[1] == plant_type

      region << node
      visited << node
      [1, -1, 1i, -1i]
        .map { [node[0] + _1, grid[node[0] + _1]] }
        .each do |neighbour|
          queue << neighbour unless neighbour[1].nil? || visited.include?(neighbour) || queue.include?(neighbour)
      end
    end
    regions[region_id] = region
    region_id += 1
  end
  regions
end

regions = flood_fill(grid)

# Part 1
part1 = regions.sum do |_id, nodes|
  area = nodes.count
  plant_type = nodes.first[1]
  sides = nodes.flat_map { |node| [1, -1, 1i, -1i].map { _1 + node[0] }.map { [_1, grid[_1]] } }
  perimeter = sides.count { |side| side[1] != plant_type }
  area * perimeter
end

# Part 2
part2 = regions.sum do |_id, nodes|
  area = nodes.count
  # TODO
  area * 0
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"

