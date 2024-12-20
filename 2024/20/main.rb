#!/usr/bin/env ruby
# frozen_string_literal: true

DIRECTIONS = [1 + 0i, -1 + 0i, 0 + 1i, 0 - 1i]

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
    # return parents if v == target

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

def path(start, target, parents, give_up_after = Float::INFINITY)
  result = [target]
  until target == start || give_up_after.zero?
    give_up_after -= 1
    target = parents[target]
    return if target.nil?

    result << target
  end
  result
end

walls = map.select { _2 == '#' }.keys.to_set
start = map.find { _2 == 'S' }.first
target = map.find { _2 == 'E' }.first
size = map.keys.map(&:real).max

parents = breadth_first_traversal(walls, size, start)
path = path(start, target, parents)

cheats = {}
path.each_with_index do |cheat_start, honest_path_remaining|
  pp 100 * honest_path_remaining.to_f / path.length
  cheat_ends = DIRECTIONS.product(DIRECTIONS).map(&:sum)
                         .reject(&:zero?)
                         .map { cheat_start + _1 }
                         .reject { map[_1] == '#' }
                         .uniq
  cheat_ends.each do |cheat_end|
    p = path(cheat_end, target, parents, honest_path_remaining)
    unless p.nil? || p.length + 1 >= honest_path_remaining
      cheats[[cheat_start, cheat_end]] = honest_path_remaining - (p.length + 1)
    end
  end
end
cheat_savings = cheats.group_by { _2 }.transform_values(&:count).sort
cheat_savings.each do |saving, count|
  puts "There #{count == 1 ? 'is one cheat' : "are #{count} cheats"} that save #{saving} picoseconds"
end

# Part 1
part1 = cheat_savings.select { _1 >= 100 }.sum { _2 }

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
