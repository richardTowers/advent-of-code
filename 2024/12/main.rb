#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'
gemfile { gem 'rspec' }
require 'rspec/autorun'

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

def walk_boundary(coords)
  start = coords.first

  wind = 1
  direction = 1
  coord = start
  sides = 1
  loop do
    neighbours = [
      coord + (direction * -1i),
      coord + direction,
      coord + (direction * 1i),
      coord - direction
    ]
    case neighbours
    in [l, _, _, _] if coords.include?(l)
      coord = l
      direction *= -1i
      sides += 1
      wind -= 1
    in [_, f, _, _] if coords.include?(f)
      coord = f
    in [_, _, r, _] if coords.include?(r)
      coord = r
      direction *= 1i
      sides += 1
      wind += 1
    in [_, _, _, b] if coords.include?(b)
      coord = b
      direction *= -1
      sides += 2
      wind += 2
    else
      # Must be a cell on its own, as none of its neighbours are in the region
      sides += 3
      wind += 3
    end
    next unless coord == start

    break
  end
  sides + (4 - wind)
end

# Tests
RSpec.describe '#walk_boundary' do
  it 'returns 4 for a single coord' do
    expect(walk_boundary([0])).to be 4
  end

  it 'returns 4 for coords in a straight horizontal line' do
    expect(walk_boundary((1..10).to_a)).to be 4
  end

  it 'returns 4 for coords in a straight vertical line' do
    expect(walk_boundary((1..10).map { _1 * 1i }.to_a)).to be 4
  end
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

  coords = nodes.map(&:first)
  sides = walk_boundary(coords)
  puts "A region of #{nodes.first[1]} plants with price #{area} * #{sides} = #{area * sides}."

  area * sides
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"

