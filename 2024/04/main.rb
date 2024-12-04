#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse input
lines = ARGF.readlines
chars = lines.map { _1.chomp.split '' }

def rotate(input)
  raise 'not square' if input.length != input.first.length

  input.transpose.map(&:reverse)
end

def diagonals(input)
  raise 'not square' if input.length != input.first.length

  indexes = (0...input.length).to_a.then { _1.product(_1) }
  indexes
    .group_by { |x, y| x - y }
    .values
    .map { |diagonal| diagonal.map { |x,y| input[y][x] } }
end

candidates = [
  chars,
  diagonals(chars),
  rotate(chars),
  diagonals(rotate(chars)),
  rotate(rotate(chars)),
  diagonals(rotate(rotate(chars))),
  rotate(rotate(rotate(chars))),
  diagonals(rotate(rotate(rotate(chars)))),
]

# Part 1
needle = %w[X M A S]
part1 = candidates.sum do |candidate|
  candidate.sum do |row|
    row.each_cons(needle.length).count(needle)
  end
end

# Part 2
part2 = nil

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
