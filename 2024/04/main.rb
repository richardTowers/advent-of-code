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
part_1_candidates = rotations.flat_map do |rotation|
  [rotation, diagonals(rotation)]
end

# Part 1
needle = %w[X M A S]
part1 = part_1_candidates.sum do |candidate|
  candidate.sum do |row|
    row.each_cons(needle.length).count(needle)
  end
end

# Part 2
needle = [
  %w[M . S],
  %w[. A .],
  %w[M . S]
]
part2 = rotations.sum do |rotation|
  rotation.each_cons(3).sum do |rows|
    candidates = rows.map { |row| row.each_cons(3).to_a }.transpose
    candidates.sum do |candidate|
      puts candidate.map(&:join).join("\n")
      if candidate[0][0] == 'M' &&
         candidate[0][2] == 'S' &&
         candidate[1][1] == 'A' &&
         candidate[2][0] == 'M' &&
         candidate[2][2] == 'S'
        1
      else
        0
      end
    end
  end
end

# Print output
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
