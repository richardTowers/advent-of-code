#!/usr/bin/env ruby
# frozen_string_literal: true

lines = ARGF.readlines
lefts, rights = lines.map(&:split).transpose
lefts.map!(&:to_i)
rights.map!(&:to_i)

# Part 1
abs_differences = lefts.sort.zip(rights.sort).map { (_1 - _2).abs }
puts "Part 1: #{abs_differences.sum}"

# Part 2
similarity_score = 0
lefts.each do |left|
  count = rights.count { |right| left == right }
  similarity_score += left * count unless count.zero?
end
puts "Part 2: #{similarity_score}"
