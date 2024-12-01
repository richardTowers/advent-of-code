#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
lefts, rights = lines.map { _1.split.map(&:to_i) }.transpose

# Part 1
part1 = lefts.sort.zip(rights.sort).map { (_1 - _2).abs }.sum
puts "Part 1: #{part1}"

# Part 2
tally = rights.tally
part2 = lefts.map { |l| tally[l]&.then { |c| l * c } }.compact.sum
puts "Part 2: #{part2}"
