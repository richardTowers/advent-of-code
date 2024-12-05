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
    .map { |diagonal| diagonal.map { |x, y| input[y][x] } }
end

rotations = [
  chars,
  rotate(chars),
  rotate(rotate(chars)),
  rotate(rotate(rotate(chars)))
]
part_1_candidates = rotations.flat_map { [_1, diagonals(_1)] }

# Part 1
needle = %w[X M A S]
part1 = part_1_candidates.sum do |candidate|
  candidate.sum do |row|
    row.each_cons(needle.length).count(needle)
  end
end

# Part 2
part2 = rotations.sum do |rotation|
  rotation.each_cons(3).sum do |rows|
    candidates = rows.map { |row| row.each_cons(3).to_a }.transpose
    candidates.sum { (_1 in [['M', _, 'S'], [_, 'A', _], ['M', _, 'S']]) ? 1 : 0 }
  end
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
