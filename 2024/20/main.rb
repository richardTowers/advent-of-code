#!/usr/bin/env ruby
# frozen_string_literal: true

DIRECTIONS = [1 + 0i, -1 + 0i, 0 + 1i, 0 - 1i].freeze

# Parse input
lines = ARGF.readlines
map = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [ri + 1i * ci, cell]
  end
end.to_h

def breadth_first_traversal(walls, size, start)
  visited = Set[start]
  parents = { start => nil }
  queue = [start]

  until queue.empty?
    v = queue.shift
    neighbours = DIRECTIONS
                 .map { v + _1 }
                 .select { |coord| coord.rect.all? { (0..size).include?(_1) } }
                 .reject { |coord| walls.include?(coord) }
                 .reject { |coord| visited.include?(coord) }
    neighbours.each do |n|
      queue << n
      visited << n
      parents[n] = v
    end
  end

  parents
end

def path(start, target, parents)
  result = [target]
  until target == start
    target = parents[target]
    result << target
  end
  result
end

walls = map.select { _2 == '#' }.keys.to_set
start = map.find { _2 == 'S' }.first
target = map.find { _2 == 'E' }.first
size = map.keys.map(&:real).max

parents = breadth_first_traversal(walls, size, start)
path = path(start, target, parents).map.with_index

def count_cheats(path, max_dist)
  path.sum do |a, a_dist|
    path.count do |b, b_dist|
      dist = (a.real - b.real).abs + (a.imag - b.imag).abs
      dist <= max_dist && b_dist + dist <= a_dist - 100
    end
  end
end

# Part 1
part1 = count_cheats(path, 2)

# Part 2
part2 = count_cheats(path, 20)

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
