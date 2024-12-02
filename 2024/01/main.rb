#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
lefts, rights = lines.map { _1.split.map(&:to_i) }.transpose

# Part 1
part1 = lefts.sort.zip(rights.sort).sum { (_1 - _2).abs }

# Part 2
tally = rights.tally
part2 = lefts.sum { |l| tally.fetch(l, 0) * l }

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
