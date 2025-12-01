#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
map = lines.flat_map.with_index do |row, ri|
  row.chomp.split('').map.with_index do |cell, ci|
    [Complex(ri + 1i * ci), cell]
  end
end.to_h

coords_and_directions = map.reject { _2 == '#' }.keys.product([1 + 0i, 1i, -1 + 0i, -1i])
start = [map.find { _2 == 'S' }.first, 1 + 0i]
e = map.find { _2 == 'E' }.first

def dijkstra(coords_and_directions, start, target)
  dist = coords_and_directions.to_h { [_1, Float::INFINITY] }
  prev = coords_and_directions.to_h { [_1, nil] }
  queue = coords_and_directions.to_set
  dist[start] = 0

  until queue.empty?
    # TODO - this is an accidental quadratic
    u = queue.min_by { dist[_1] }
    queue.delete(u)
    pp queue.length if (queue.length % 100).zero?
    break if u[0] == target

    neighbours = [[u[0] + u[1], u[1]], [u[0], u[1] * 1i], [u[0], u[1] * -1i]]
    neighbours.each do |coord, direction|
      v = [coord, direction]
      next unless queue.include?(v)

      score = direction == u[1] ? 1 : 1000
      alt = dist[u] + score
      if alt < dist[v]
        dist[v] = alt
        prev[v] = u
      end
    end
  end

  [dist, prev]
end

dist, prev = dijkstra(coords_and_directions, start, e)

# Part 1
part1 = dist.select { |key,| key.first == e }.values.min - 1000 # hack

binding.irb

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
