#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
walls = lines.map.with_index do |line, time|
  x, y = line.split(',').map(&:to_i)
  [x + 1i * y, time]
end

def bfs(walls, size, start, target)
  directions = [1 + 0i, -1 + 0i, 0 + 1i, 0 - 1i]
  visited = Set[]
  queue = [start]
  until queue.empty?
    v = queue.shift
    return v[1] if v[0] == target

    neighbours = directions
                 .map { [v[0] + _1, v[1].next] }
                 .select { |coord, _| coord.rect.all? { (0..size).include?(_1) } }
                 .reject { |coord, _| walls.select { _2 <= 1024 }.map(&:first).include?(coord) }
                 .reject { |coord, _| visited.include?(coord) }
    neighbours.each do |n|
      queue << n
      visited << n[0]
    end
  end
end

# Part 1
part1 = bfs(walls, 70, [0i, 0], 70 + 70i)

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
