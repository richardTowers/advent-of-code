#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
lefts, rights = lines.map { _1.split.map(&:to_i) }.transpose

# Part 1
puts "Part 1: #{lefts.sort.zip(rights.sort).map { (_1 - _2).abs }.sum}"

# Part 2
tally = rights.tally
puts "Part 2: #{lefts.map { |l| tally[l]&.then { |c| l * c } }.compact.sum}"
