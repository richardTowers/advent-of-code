#!/usr/bin/env ruby
# frozen_string_literal: true

$memo = {}
def count_arrangements(target, patterns)
  $memo[target] ||=
    if target.empty?
      1
    else
      patterns.select { target.start_with?(_1) }.sum do |prefix|
        count_arrangements(target.sub(/^#{prefix}/, ''), patterns)
      end
    end
end

# Parse input
lines = ARGF.readlines.map(&:chomp)

available_patterns = lines[0].split(', ').to_set
desired_results = lines[2..]

# Part 1
counts = desired_results.map { count_arrangements(_1, available_patterns) }
part1 = counts.count(&:positive?)

# Part 2
part2 = counts.sum

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
