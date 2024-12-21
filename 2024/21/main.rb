#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'

def breadth_first_traversal(keypad, start)
  parents = { start => nil }
  queue = [start]
  until queue.empty?
    v = queue.shift
    [1 + 0i, -1 + 0i, 0 + 1i, 0 - 1i]
      .map { v + _1 }
      .select { |coord| keypad.include?(coord) }
      .reject { |coord| parents.key?(coord) }
      .each { |coord| queue << coord }
      .each { |coord| parents[coord] = v }
  end
  parents
end

def path(start, target, parents)
  result = [target]
  until target == start
    target = parents[target]
    result << target
  end
  result.reverse
end

numeric_keypad = {
  '7' => 0 + 0i, '8' => 1 + 0i, '9' => 2 + 0i,
  '4' => 0 + 1i, '5' => 1 + 1i, '6' => 2 + 1i,
  '1' => 0 + 2i, '2' => 1 + 2i, '3' => 2 + 2i,
  '0' => 1 + 3i, 'A' => 2 + 3i,
}
directional_keypad = {
  '^' => 1 + 0i, 'A' => 2 + 0i,
  '<' => 0 + 1i, 'v' => 1 + 1i, '>' => 2 + 1i
}
directions = { 1 + 0i => '>', -1 + 0i => '<', 0 + 1i => 'v', 0 - 1i => '^' }

paths = {}
numeric_keypad.each do |start_key, start_coord|
  parents = breadth_first_traversal(numeric_keypad.values.to_set, start_coord)
  numeric_keypad.each do |end_key, end_coord|
    path = path(start_coord, end_coord, parents)
    path_dirs = path.each_cons(2).map { _2 - _1 }
    paths[[start_key, end_key]] = path_dirs.map { directions[_1] }
  end
end

numeric_sequence1 = %w[0 2 9 A]
direction_sequence1 = (['A'] + numeric_sequence1).each_cons(2).map { |from, to| paths[[from, to]].join('') }.join('A')
pp [numeric_sequence1, direction_sequence1]
# move from A to 0
# move from 0 to A
# push A
# move from A to 2
# move from 2 to A
# push A
# move from A to 9
# move from 9 at A
# push A

# Parse input
_lines = ARGF.readlines

# Part 1
part1 = nil

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
